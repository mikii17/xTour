import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_tour/custom/custom.dart';
import 'package:x_tour/journal/bloc/load_journal_bloc.dart';
import 'package:x_tour/journal/repository/journal_repository.dart';
import 'package:x_tour/journal/screens/create_journalScreen.dart';
import 'package:x_tour/screens/error_page.dart';
import 'package:x_tour/user/bloc/user_bloc.dart';
import 'package:x_tour/screens/screens.dart';

class JournalListScreen extends StatefulWidget {
  @override
  State<JournalListScreen> createState() => _JournalListScreenState();
}

class _JournalListScreenState extends State<JournalListScreen> {
  late LoadJournalBloc loadJournalBloc;
  int currentPage = 1;
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    loadJournalBloc = LoadJournalBloc(
        journalRepository: context.read<JournalRepository>(),
        userBloc: context.read<UserBloc>())
      ..add(const LoadJournals());
    _scrollController.addListener(_scrollListner);
  }

  @override
  void dispose() {
    loadJournalBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: XTourAppBar(
        leading: Image(image: AssetImage('assets/Logo.png')),
        title: "Journal Post",
        showActionIcon: Transform.translate(
          offset: const Offset(10, 0),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateJournalScreen(),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
      body: BlocBuilder<LoadJournalBloc, LoadJournalState>(
        bloc: loadJournalBloc,
        builder: (context, state) {
          if (state is JournalLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is JournalsFailed) {
            return ElevatedButton(
                onPressed: () {
                  loadJournalBloc.add(const LoadJournals());
                },
                child: Text("Try Again!"));
          }

          if (state is JournalsLoaded) {
            final journals = state.journals;
            final user =
                (context.read<UserBloc>().state as UserOperationSuccess).user;
            return ListView.separated(
              controller: _scrollController,
              itemCount: journals.length,
              itemBuilder: (context, index) {
                final journal = journals[index];
                return journalCard(
                  journal: journal,
                  user: user,
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 20,
                );
              },
            );
          }
          return ErrorPage();
        },
      ),
    );
  }

  void _scrollListner() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    final threshold = maxScroll * 0.7;

    if (currentScroll > threshold) {
      currentPage += 1;
      loadJournalBloc.add(LoadMoreJournals(page: currentPage));
    }
  }
}

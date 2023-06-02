import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_tour/custom/custom.dart';
import 'package:x_tour/journal/repository/journal_repository.dart';

import '../../custom/pendingJournalCard.dart';
import '../../user/bloc/user_bloc.dart';
import '../../user/pending_journal/bloc/pending_journal_bloc.dart';
import '../../user/repository/user_repository.dart';
import '../models/journal.dart';

class PendingJournalListScreen extends StatefulWidget {
  @override
  State<PendingJournalListScreen> createState() =>
      _PendingJournalListScreenState();
}

class _PendingJournalListScreenState extends State<PendingJournalListScreen> {
  late PendingJournalBloc pendingJournalBloc;
  late UserBloc userBloc;

  @override
  void initState() {
    super.initState();
    userBloc = context.read<UserBloc>();
    pendingJournalBloc = PendingJournalBloc(
        userRepository: context.read<UserRepository>(),
        journalRepository: context.read<JournalRepository>(),
        userBloc: userBloc)
      ..add(const GetPendingJournal());
  }

  @override
  void dispose() {
    pendingJournalBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PendingJournalBloc, PendingJournalState>(
      builder: (context, state) {
        if (state is PendingJournalLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is PendingJournalOperationSuccess) {
          final List<Journal> journals = state.journals;
          return Scaffold(
            appBar: const XTourAppBar(
              title: 'Pending Journal List',
            ),
            body: ListView.builder(
              itemCount: journals.length,
              itemBuilder: (context, index) {
                return PendingJournalCard(
                  pendingJournalBloc: pendingJournalBloc,
                  journal: journals[index],
                  user: (userBloc.state as UserOperationSuccess).user,
                  userBloc: userBloc,
                );
              },
            ),
          );
        }
        return Container();
      },
    );
  }
}

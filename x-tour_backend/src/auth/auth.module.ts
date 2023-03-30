import { Module } from '@nestjs/common';
import { UserModule } from 'src/user/user.module';
import { AuthController } from './auth.controller';
import { AuthService } from './auth.service';
import { PassportModule } from '@nestjs/passport';
import { LocalStrategy } from './local.strategy';
import { JwtModule } from '@nestjs/jwt';
import { AtStrategy } from './strategies/at.strategy';
import { RtStrategy } from './strategies/rt.strategy';
import { APP_GUARD } from '@nestjs/core';
import { RolesGuard } from './guard/roles.guard';

@Module({
  imports:[UserModule, PassportModule,JwtModule.register({}),],
  controllers: [AuthController],
  providers: [AuthService, 
    LocalStrategy, 
    AtStrategy, 
    RtStrategy,
    {
      provide: APP_GUARD,
      useClass: RolesGuard,
    },
  ]
})
export class AuthModule {}

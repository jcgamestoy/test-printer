import { Basic } from 'dione'
import { Debugger } from 'retrostudio:debugger'

Debugger.boot('+3 basic')
Debugger.loadBasic(Basic.sinclair('src/zx.bas'))
// En la maquina: RUN

import { Basic } from 'dione'
import { Debugger } from 'retrostudio:debugger'

Debugger.boot()
Debugger.loadBasic(Basic.locomotive('src/cpc.bas'))
// En la maquina: RUN

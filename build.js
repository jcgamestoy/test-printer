// Compila las pruebas de la DMP-2000 y escribe los medios para cargarlas en RVM3:
//  - CPC 6128: impresora-cpc.dsk (RUN"DMPTEST") y impresora-cpc.cdt (RUN")
//  - +2A/+3:   impresora-zx.dsk (se carga solo desde el Loader del +3) e impresora-zx.tap (LOAD "")
import { Basic, Disk, Tape, Console } from 'dione'

const cpc = Basic.locomotive('src/cpc.bas')
const zx = Basic.sinclair('src/zx.bas')

new Disk().addCpcBasic('DMPTEST.BAS', cpc.data).saveDsk('out/impresora-cpc.dsk')
new Tape().addCpcBasic('DMPTEST', cpc.data).saveCdt('out/impresora-cpc.cdt')
new Disk().addZxProgram('DISK', zx, 10).saveDsk('out/impresora-zx.dsk')
new Tape().addZxProgram('dmptest', zx, 10).saveZxTap('out/impresora-zx.tap')

Console.lime(`CPC: ${cpc.data.length} bytes, ZX: ${zx.data.length} bytes\n`).reset()

# demo-AsIOVib
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
demo for B&amp;R - Automation Studio Library AsIOVib

shows how to upload raw data from [X20CM4810](https://www.br-automation.com/en/products/control-systems/x20-system/other-functions/x20cm4810/) condition monitoring module.
Uses 'AsIOVib' / 'vbioCtrlCM4810Ex1'

There is no comfort here, no visualization, no storing in files. If you still need that, think about [PLC-data-trace](https://github.com/hilch/PLC-data-trace)

## Usage:

set 'cmdUploadBuffer' to '1', task will set it to '2' (busy) and to '0' again when buffer is uploaded.
see 'fb.bufferUploadLength' for progress.
X and Y sensor data is stored in 'moduleData.xAxis' and 'moduleData.yAxis'.



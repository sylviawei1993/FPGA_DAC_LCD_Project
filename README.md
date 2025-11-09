# FPGA_DAC_LCD_Project
SeoulTech FPGA DAC + 7Segment + LCD Experiment (E Assignment)
# FPGA DAC + 7-Segment + LCD Experiment (E Assignment)

##  Experiment Objective
본 실험의 목적은 FPGA 보드와 8비트 DAC(AD7302)를 이용하여  
디지털 신호를 아날로그 신호로 변환하고,  
버튼 입력에 따라 DAC 입력값을 변경하며  
7-Segment와 Text LCD에 해당 값을 실시간으로 표시하는 것이다.

##  Functions Implemented
- 1, 3, 4, 6, 7, 9번 버튼을 이용한 DAC 입력 증감
- 7-Segment를 통한 DAC 값의 10진수 표시
- Text LCD에 `"DAC IN = XX"` 출력
- DAC 출력 전압의 실시간 변화 확인

##  Files in this Repository
| File | Description |
|------|--------------|
| `DAC_7SEG_LCD_XCS75.v` | Main top module |
| `seg7_decoder.v` | 7-Segment decoder |
| `lcd_display.v` | LCD display controller |
| `oneshot_universal.v` | One-shot trigger for button |
| `DAC_LCD_top.xdc` | FPGA pin constraint file |
| `result_report.pdf` | Experiment report |
| `photo1.png`, `photo2.png` | Hardware test results |

## 🧠 Notes
- Board: XCS75FGGA484-1 (SeoulTech FPGA Board)  
- DAC: AD7302  
- Tool: Vivado 2025.1  
- Language: Verilog HDL  


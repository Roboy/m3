EESchema Schematic File Version 4
LIBS:roboy_sno-cache
EELAYER 26 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Text GLabel 9825 4100 2    50   Input ~ 0
VDD5V
Text GLabel 9900 3700 2    50   Input ~ 0
GND
$Comp
L roboy_sno-rescue:C-Device C3
U 1 1 5ABD740F
P 9700 3950
F 0 "C3" H 9815 3996 50  0000 L CNN
F 1 "10uF" H 9815 3905 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 9738 3800 50  0001 C CNN
F 3 "~" H 9700 3950 50  0001 C CNN
	1    9700 3950
	1    0    0    -1  
$EndComp
$Comp
L roboy_sno-rescue:C-Device C2
U 1 1 5ABD7467
P 8300 3950
F 0 "C2" H 8415 3996 50  0000 L CNN
F 1 "10uF" H 8415 3905 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 8338 3800 50  0001 C CNN
F 3 "~" H 8300 3950 50  0001 C CNN
	1    8300 3950
	1    0    0    -1  
$EndComp
$Comp
L roboy_sno-rescue:LD39200-roboy_sno U1
U 1 1 5AB658D6
P 9050 4200
F 0 "U1" H 9000 4525 50  0000 C CNN
F 1 "LD39200" H 9000 4434 50  0000 C CNN
F 2 "Package_DFN_QFN:DFN-6-1EP_3x3mm_P0.95mm_EP1.7x2.6mm" H 9050 4200 50  0001 C CNN
F 3 "" H 9050 4200 50  0001 C CNN
	1    9050 4200
	1    0    0    -1  
$EndComp
Wire Wire Line
	8300 4100 8550 4100
Wire Wire Line
	9450 4100 9700 4100
Wire Wire Line
	9900 3700 9700 3700
Wire Wire Line
	8300 3700 8300 3800
Wire Wire Line
	9700 3800 9700 3700
Connection ~ 9700 3700
Wire Wire Line
	9700 3700 8300 3700
Text GLabel 8050 4100 0    50   Input ~ 0
3.3V
Wire Wire Line
	8550 4200 8300 4200
Wire Wire Line
	8300 4200 8300 4100
Connection ~ 8300 4100
Text GLabel 8450 4300 0    50   Input ~ 0
GND
Wire Wire Line
	8450 4300 8550 4300
Wire Wire Line
	8300 4100 8050 4100
$Comp
L roboy_sno-rescue:Conn_01x02_Male-Connector J5
U 1 1 5B881020
P 7575 2975
F 0 "J5" H 7548 2855 50  0000 R CNN
F 1 "Conn_01x02_Male" H 7548 2946 50  0000 R CNN
F 2 "Pin_Headers:Pin_Header_Angled_1x02_Pitch2.54mm" H 7575 2975 50  0001 C CNN
F 3 "~" H 7575 2975 50  0001 C CNN
	1    7575 2975
	-1   0    0    1   
$EndComp
Text GLabel 7375 2875 0    50   Input ~ 0
VDD5V
Text GLabel 7375 2975 0    50   Input ~ 0
GND
Text GLabel 3250 3875 3    50   Input ~ 0
GND
Wire Wire Line
	7175 1675 7375 1675
$Comp
L roboy_sno-rescue:D_Schottky-Device D?
U 1 1 5C1B4309
P 7025 1675
AR Path="/5ABCD2F9/5C1B4309" Ref="D?"  Part="1" 
AR Path="/5C1B4309" Ref="D2"  Part="1" 
F 0 "D2" H 7025 1891 50  0000 C CNN
F 1 "D_Schottky" H 7025 1800 50  0000 C CNN
F 2 "Diodes_SMD:D_SOD-123F" H 7025 1675 50  0001 C CNN
F 3 "~" H 7025 1675 50  0001 C CNN
	1    7025 1675
	1    0    0    -1  
$EndComp
Text GLabel 7675 1075 0    50   Input ~ 0
GND
$Comp
L roboy_sno-rescue:USB_B_Mini-Connector_Specialized J?
U 1 1 5C1B4385
P 7675 1475
AR Path="/5ABCD2F9/5C1B4385" Ref="J?"  Part="1" 
AR Path="/5C1B4385" Ref="J1"  Part="1" 
F 0 "J1" H 7446 1373 50  0000 R CNN
F 1 "USB_B_Mini" H 7446 1464 50  0000 R CNN
F 2 "Connectors_USB:USB_Micro-B_Molex_47346-0001" H 7825 1425 50  0001 C CNN
F 3 "~" H 7825 1425 50  0001 C CNN
	1    7675 1475
	-1   0    0    1   
$EndComp
Text GLabel 3250 750  1    50   Input ~ 0
3.3V
Text GLabel 6875 1675 0    50   Input ~ 0
VDD5V
Text GLabel 9450 4300 2    50   Input ~ 0
PWRGOOD
Wire Wire Line
	9825 4100 9725 4100
Connection ~ 9700 4100
$Comp
L LED:SK6812 D1
U 1 1 5C1E509E
P 4550 4550
F 0 "D1" H 4225 4400 50  0000 L CNN
F 1 "SK6812" H 4150 4800 50  0000 L CNN
F 2 "custom_lib:LED_WS2812B-PLCC4_3.5x3.5" H 4600 4250 50  0001 L TNN
F 3 "https://cdn-shop.adafruit.com/product-files/1138/SK6812+LED+datasheet+.pdf" H 4650 4175 50  0001 L TNN
	1    4550 4550
	1    0    0    -1  
$EndComp
Text GLabel 4550 5075 3    50   Input ~ 0
GND
Text GLabel 4550 4125 1    50   Input ~ 0
VDD5V
Text GLabel 4250 4550 0    50   Input ~ 0
NEOPX
$Comp
L Device:R_POT RV1
U 1 1 5C1F5A93
P 2250 1575
F 0 "RV1" H 2180 1621 50  0000 R CNN
F 1 "R_POT" H 2180 1530 50  0000 R CNN
F 2 "Potentiometer_THT:Potentiometer_Bourns_PTA2043_Single_Slide" H 2250 1575 50  0001 C CNN
F 3 "~" H 2250 1575 50  0001 C CNN
	1    2250 1575
	1    0    0    -1  
$EndComp
Text GLabel 2225 1350 0    50   Input ~ 0
3.3V
Text GLabel 2225 1775 0    50   Input ~ 0
GND
Text GLabel 7350 2300 0    50   Input ~ 0
GND
Text GLabel 7350 2400 0    50   Input ~ 0
VDD5V
Wire Wire Line
	9725 4100 9725 4200
Wire Wire Line
	9725 4200 9450 4200
Connection ~ 9725 4100
Wire Wire Line
	9725 4100 9700 4100
$Comp
L roboy_sno-rescue:R-Device R?
U 1 1 5C1E0207
P 1625 1100
AR Path="/5ABCD2F9/5C1E0207" Ref="R?"  Part="1" 
AR Path="/5C1E0207" Ref="R10"  Part="1" 
F 0 "R10" H 1555 1054 50  0000 R CNN
F 1 "10k" H 1555 1145 50  0000 R CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 1555 1100 50  0001 C CNN
F 3 "~" H 1625 1100 50  0001 C CNN
	1    1625 1100
	-1   0    0    1   
$EndComp
Text GLabel 1625 950  1    50   Input ~ 0
3.3V
Wire Wire Line
	1625 1275 1625 1250
NoConn ~ 7375 1375
NoConn ~ 7375 1475
Wire Wire Line
	7775 1075 7675 1075
NoConn ~ 7375 1275
Wire Wire Line
	2650 1575 2400 1575
Text GLabel 5425 850  0    50   Input ~ 0
VDD5V
Text GLabel 5425 950  0    50   Input ~ 0
GND
Text GLabel 3850 1375 2    50   Input ~ 0
TXD
Text GLabel 3850 1575 2    50   Input ~ 0
RXD
Text GLabel 5425 1050 0    50   Input ~ 0
TXD
Text GLabel 5425 1150 0    50   Input ~ 0
RXD
Text GLabel 5000 2100 0    50   Input ~ 0
ID0
Text GLabel 6100 2300 2    50   Input ~ 0
3.3V
Text GLabel 2075 950  1    50   Input ~ 0
GND
$Comp
L roboy_sno-rescue:C-Device C1
U 1 1 5CD59FD3
P 2075 1100
F 0 "C1" H 2190 1146 50  0000 L CNN
F 1 "0.1uF" H 2190 1055 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 2113 950 50  0001 C CNN
F 3 "~" H 2075 1100 50  0001 C CNN
	1    2075 1100
	1    0    0    -1  
$EndComp
Wire Wire Line
	2075 1250 2075 1275
$Comp
L Switch:SW_Push SW1
U 1 1 5CD5A84F
P 2450 1075
F 0 "SW1" V 2404 1223 50  0000 L CNN
F 1 "RESET" V 2495 1223 50  0000 L CNN
F 2 "custom_lib:SW_SPST_KXT3" H 2450 1275 50  0001 C CNN
F 3 "" H 2450 1275 50  0001 C CNN
	1    2450 1075
	0    1    1    0   
$EndComp
Connection ~ 2075 1275
Wire Wire Line
	2075 1275 2450 1275
Wire Wire Line
	1625 1275 2075 1275
Connection ~ 2450 1275
Wire Wire Line
	2450 1275 2650 1275
Text GLabel 2450 875  1    50   Input ~ 0
GND
$Comp
L Switch:SW_Push SW2
U 1 1 5CD5B563
P 3850 1075
F 0 "SW2" H 3850 1000 50  0000 C CNN
F 1 "BOOT" H 3850 1200 50  0000 C CNN
F 2 "custom_lib:SW_SPST_KXT3" H 3850 1275 50  0001 C CNN
F 3 "" H 3850 1275 50  0001 C CNN
	1    3850 1075
	0    1    1    0   
$EndComp
Text GLabel 3850 875  1    50   Input ~ 0
GND
$Comp
L Switch:SW_DIP_x05 SW5
U 1 1 5CD5C24B
P 5300 2300
F 0 "SW5" H 5300 2767 50  0000 C CNN
F 1 "SW_DIP_x05" H 5300 2676 50  0000 C CNN
F 2 "Button_Switch_SMD:SW_DIP_SPSTx05_Slide_6.7x14.26mm_W8.61mm_P2.54mm_LowProfile" H 5300 2300 50  0001 C CNN
F 3 "" H 5300 2300 50  0001 C CNN
	1    5300 2300
	1    0    0    -1  
$EndComp
Text GLabel 5000 2200 0    50   Input ~ 0
ID1
Text GLabel 5000 2300 0    50   Input ~ 0
ID2
Text GLabel 5000 2400 0    50   Input ~ 0
ID3
Text GLabel 5000 2500 0    50   Input ~ 0
ID4
$Comp
L roboy_sno-rescue:R-Device R?
U 1 1 5CD5D033
P 5750 2500
AR Path="/5ABCD2F9/5CD5D033" Ref="R?"  Part="1" 
AR Path="/5CD5D033" Ref="R12"  Part="1" 
F 0 "R12" V 5750 2375 50  0000 R CNN
F 1 "10k" V 5750 2550 50  0000 R CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 5680 2500 50  0001 C CNN
F 3 "~" H 5750 2500 50  0001 C CNN
	1    5750 2500
	0    1    1    0   
$EndComp
$Comp
L roboy_sno-rescue:R-Device R?
U 1 1 5CD5D777
P 5750 2400
AR Path="/5ABCD2F9/5CD5D777" Ref="R?"  Part="1" 
AR Path="/5CD5D777" Ref="R11"  Part="1" 
F 0 "R11" V 5750 2275 50  0000 R CNN
F 1 "10k" V 5750 2450 50  0000 R CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 5680 2400 50  0001 C CNN
F 3 "~" H 5750 2400 50  0001 C CNN
	1    5750 2400
	0    1    1    0   
$EndComp
$Comp
L roboy_sno-rescue:R-Device R?
U 1 1 5CD5D7B1
P 5750 2300
AR Path="/5ABCD2F9/5CD5D7B1" Ref="R?"  Part="1" 
AR Path="/5CD5D7B1" Ref="R9"  Part="1" 
F 0 "R9" V 5750 2175 50  0000 R CNN
F 1 "10k" V 5750 2350 50  0000 R CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 5680 2300 50  0001 C CNN
F 3 "~" H 5750 2300 50  0001 C CNN
	1    5750 2300
	0    1    1    0   
$EndComp
$Comp
L roboy_sno-rescue:R-Device R?
U 1 1 5CD5D7EB
P 5750 2200
AR Path="/5ABCD2F9/5CD5D7EB" Ref="R?"  Part="1" 
AR Path="/5CD5D7EB" Ref="R8"  Part="1" 
F 0 "R8" V 5750 2075 50  0000 R CNN
F 1 "10k" V 5750 2250 50  0000 R CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 5680 2200 50  0001 C CNN
F 3 "~" H 5750 2200 50  0001 C CNN
	1    5750 2200
	0    1    1    0   
$EndComp
$Comp
L roboy_sno-rescue:R-Device R?
U 1 1 5CD5D827
P 5750 2100
AR Path="/5ABCD2F9/5CD5D827" Ref="R?"  Part="1" 
AR Path="/5CD5D827" Ref="R7"  Part="1" 
F 0 "R7" V 5750 1975 50  0000 R CNN
F 1 "10k" V 5750 2150 50  0000 R CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 5680 2100 50  0001 C CNN
F 3 "~" H 5750 2100 50  0001 C CNN
	1    5750 2100
	0    1    1    0   
$EndComp
Wire Wire Line
	5900 2100 6025 2100
Wire Wire Line
	6025 2100 6025 2200
Wire Wire Line
	6025 2300 6100 2300
Wire Wire Line
	6025 2300 6025 2400
Wire Wire Line
	6025 2500 5900 2500
Connection ~ 6025 2300
Wire Wire Line
	5900 2400 6025 2400
Connection ~ 6025 2400
Wire Wire Line
	6025 2400 6025 2500
Wire Wire Line
	5900 2300 6025 2300
Wire Wire Line
	5900 2200 6025 2200
Connection ~ 6025 2200
Wire Wire Line
	6025 2200 6025 2300
Text GLabel 3850 1675 2    50   Input ~ 0
ID0
Text GLabel 3850 2275 2    50   Input ~ 0
ID1
Text GLabel 3850 2975 2    50   Input ~ 0
NEOPX
Text GLabel 3850 2575 2    50   Input ~ 0
MOTOR
$Comp
L RF_Module:ESP32-WROOM-32 U2
U 1 1 5CD5F722
P 3250 2475
F 0 "U2" H 3250 2625 50  0000 C CNN
F 1 "ESP32-WROOM-32" H 3175 1675 50  0000 C CNN
F 2 "custom_lib:ESP32-WROOM-32-Espressif-Symbol-Kicad-62379" H 3250 975 50  0001 C CNN
F 3 "https://www.espressif.com/sites/default/files/documentation/esp32-wroom-32_datasheet_en.pdf" H 2950 2525 50  0001 C CNN
	1    3250 2475
	1    0    0    -1  
$EndComp
NoConn ~ 3850 1475
Text GLabel 4275 2075 2    50   Input ~ 0
MTMS
Text GLabel 4275 1875 2    50   Input ~ 0
MTDI
Text GLabel 4275 1975 2    50   Input ~ 0
MTCK
Text GLabel 4275 2175 2    50   Input ~ 0
MTDO
$Comp
L roboy_sno-rescue:R-Device R?
U 1 1 5CD64770
P 4000 1875
AR Path="/5ABCD2F9/5CD64770" Ref="R?"  Part="1" 
AR Path="/5CD64770" Ref="R1"  Part="1" 
F 0 "R1" V 4000 1775 50  0000 R CNN
F 1 "100" V 4000 1950 50  0000 R CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 3930 1875 50  0001 C CNN
F 3 "~" H 4000 1875 50  0001 C CNN
	1    4000 1875
	0    -1   -1   0   
$EndComp
Wire Wire Line
	4275 1875 4150 1875
$Comp
L roboy_sno-rescue:R-Device R?
U 1 1 5CD65C84
P 4000 1975
AR Path="/5ABCD2F9/5CD65C84" Ref="R?"  Part="1" 
AR Path="/5CD65C84" Ref="R2"  Part="1" 
F 0 "R2" V 4000 1875 50  0000 R CNN
F 1 "100" V 4000 2050 50  0000 R CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 3930 1975 50  0001 C CNN
F 3 "~" H 4000 1975 50  0001 C CNN
	1    4000 1975
	0    -1   -1   0   
$EndComp
Wire Wire Line
	4275 1975 4150 1975
$Comp
L roboy_sno-rescue:R-Device R?
U 1 1 5CD66330
P 4000 2075
AR Path="/5ABCD2F9/5CD66330" Ref="R?"  Part="1" 
AR Path="/5CD66330" Ref="R3"  Part="1" 
F 0 "R3" V 4000 1975 50  0000 R CNN
F 1 "100" V 4000 2150 50  0000 R CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 3930 2075 50  0001 C CNN
F 3 "~" H 4000 2075 50  0001 C CNN
	1    4000 2075
	0    -1   -1   0   
$EndComp
Wire Wire Line
	4275 2075 4150 2075
$Comp
L roboy_sno-rescue:R-Device R?
U 1 1 5CD66337
P 4000 2175
AR Path="/5ABCD2F9/5CD66337" Ref="R?"  Part="1" 
AR Path="/5CD66337" Ref="R4"  Part="1" 
F 0 "R4" V 4000 2075 50  0000 R CNN
F 1 "100" V 4000 2250 50  0000 R CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 3930 2175 50  0001 C CNN
F 3 "~" H 4000 2175 50  0001 C CNN
	1    4000 2175
	0    -1   -1   0   
$EndComp
Wire Wire Line
	4275 2175 4150 2175
Text GLabel 3850 2375 2    50   Input ~ 0
ID2
Text GLabel 3850 1775 2    50   Input ~ 0
ID3
Text GLabel 3850 2475 2    50   Input ~ 0
ID4
Text GLabel 3850 2675 2    50   Input ~ 0
MOTOR_SENSE
$Comp
L LED:SK6812 D3
U 1 1 5CD68D53
P 5250 4550
F 0 "D3" H 4925 4400 50  0000 L CNN
F 1 "SK6812" H 4850 4800 50  0000 L CNN
F 2 "custom_lib:LED_WS2812B-PLCC4_3.5x3.5" H 5300 4250 50  0001 L TNN
F 3 "https://cdn-shop.adafruit.com/product-files/1138/SK6812+LED+datasheet+.pdf" H 5350 4175 50  0001 L TNN
	1    5250 4550
	1    0    0    -1  
$EndComp
$Comp
L LED:SK6812 D4
U 1 1 5CD68DC5
P 5950 4550
F 0 "D4" H 5625 4400 50  0000 L CNN
F 1 "SK6812" H 5550 4800 50  0000 L CNN
F 2 "custom_lib:LED_WS2812B-PLCC4_3.5x3.5" H 6000 4250 50  0001 L TNN
F 3 "https://cdn-shop.adafruit.com/product-files/1138/SK6812+LED+datasheet+.pdf" H 6050 4175 50  0001 L TNN
	1    5950 4550
	1    0    0    -1  
$EndComp
$Comp
L LED:SK6812 D5
U 1 1 5CD69702
P 6650 4550
F 0 "D5" H 6325 4400 50  0000 L CNN
F 1 "SK6812" H 6250 4800 50  0000 L CNN
F 2 "custom_lib:LED_WS2812B-PLCC4_3.5x3.5" H 6700 4250 50  0001 L TNN
F 3 "https://cdn-shop.adafruit.com/product-files/1138/SK6812+LED+datasheet+.pdf" H 6750 4175 50  0001 L TNN
	1    6650 4550
	1    0    0    -1  
$EndComp
$Comp
L LED:SK6812 D6
U 1 1 5CD69708
P 7350 4550
F 0 "D6" H 7025 4400 50  0000 L CNN
F 1 "SK6812" H 6950 4800 50  0000 L CNN
F 2 "custom_lib:LED_WS2812B-PLCC4_3.5x3.5" H 7400 4250 50  0001 L TNN
F 3 "https://cdn-shop.adafruit.com/product-files/1138/SK6812+LED+datasheet+.pdf" H 7450 4175 50  0001 L TNN
	1    7350 4550
	1    0    0    -1  
$EndComp
Wire Wire Line
	4850 4550 4950 4550
Wire Wire Line
	5550 4550 5650 4550
Wire Wire Line
	6250 4550 6350 4550
Wire Wire Line
	6950 4550 7050 4550
Wire Wire Line
	4550 4250 4900 4250
Wire Wire Line
	5250 4250 5600 4250
Connection ~ 5250 4250
Wire Wire Line
	5950 4250 6300 4250
Connection ~ 5950 4250
Wire Wire Line
	6650 4250 7000 4250
Connection ~ 6650 4250
Wire Wire Line
	4550 4125 4550 4250
Connection ~ 4550 4250
NoConn ~ 7650 4550
$Comp
L roboy_sno-rescue:C-Device C9
U 1 1 5CD76F57
P 7000 4825
F 0 "C9" H 7115 4871 50  0000 L CNN
F 1 "0.1u" H 7115 4780 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 7038 4675 50  0001 C CNN
F 3 "~" H 7000 4825 50  0001 C CNN
	1    7000 4825
	1    0    0    -1  
$EndComp
$Comp
L roboy_sno-rescue:C-Device C8
U 1 1 5CD772E8
P 6300 4825
F 0 "C8" H 6415 4871 50  0000 L CNN
F 1 "0.1u" H 6415 4780 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 6338 4675 50  0001 C CNN
F 3 "~" H 6300 4825 50  0001 C CNN
	1    6300 4825
	1    0    0    -1  
$EndComp
$Comp
L roboy_sno-rescue:C-Device C7
U 1 1 5CD7735A
P 5600 4825
F 0 "C7" H 5715 4871 50  0000 L CNN
F 1 "0.1u" H 5715 4780 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 5638 4675 50  0001 C CNN
F 3 "~" H 5600 4825 50  0001 C CNN
	1    5600 4825
	1    0    0    -1  
$EndComp
$Comp
L roboy_sno-rescue:C-Device C6
U 1 1 5CD773D6
P 4900 4825
F 0 "C6" H 5015 4871 50  0000 L CNN
F 1 "0.1u" H 5015 4780 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 4938 4675 50  0001 C CNN
F 3 "~" H 4900 4825 50  0001 C CNN
	1    4900 4825
	1    0    0    -1  
$EndComp
Wire Wire Line
	4550 4850 4550 4975
Wire Wire Line
	4900 4975 4550 4975
Connection ~ 4550 4975
Wire Wire Line
	4550 4975 4550 5075
Wire Wire Line
	4900 4975 5250 4975
Connection ~ 4900 4975
Wire Wire Line
	5600 4975 5950 4975
Connection ~ 5600 4975
Wire Wire Line
	6300 4975 6650 4975
Connection ~ 6300 4975
Wire Wire Line
	7000 4675 7000 4250
Connection ~ 7000 4250
Wire Wire Line
	7000 4250 7350 4250
Wire Wire Line
	6300 4675 6300 4250
Connection ~ 6300 4250
Wire Wire Line
	6300 4250 6650 4250
Wire Wire Line
	5600 4675 5600 4250
Connection ~ 5600 4250
Wire Wire Line
	5600 4250 5950 4250
Wire Wire Line
	4900 4675 4900 4250
Connection ~ 4900 4250
Wire Wire Line
	4900 4250 5250 4250
Wire Wire Line
	5250 4850 5250 4975
Connection ~ 5250 4975
Wire Wire Line
	5250 4975 5600 4975
Wire Wire Line
	5950 4850 5950 4975
Connection ~ 5950 4975
Wire Wire Line
	5950 4975 6300 4975
Wire Wire Line
	6650 4850 6650 4975
Connection ~ 6650 4975
Wire Wire Line
	6650 4975 7000 4975
Wire Wire Line
	7350 4850 7350 4975
Wire Wire Line
	7350 4975 7000 4975
Connection ~ 7000 4975
Wire Wire Line
	2250 1725 2250 1775
Wire Wire Line
	2250 1775 2225 1775
Wire Wire Line
	2225 1350 2250 1350
Wire Wire Line
	2250 1350 2250 1425
NoConn ~ 2650 1475
$Comp
L Connector:Conn_01x04_Male J2
U 1 1 5CD5B969
P 7550 2500
F 0 "J2" H 7523 2380 50  0000 R CNN
F 1 "Conn_01x04_Male" H 7523 2471 50  0000 R CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x04_P2.54mm_Vertical" H 7550 2500 50  0001 C CNN
F 3 "~" H 7550 2500 50  0001 C CNN
	1    7550 2500
	-1   0    0    1   
$EndComp
Text GLabel 7350 2500 0    50   Input ~ 0
MOTOR
Text GLabel 7350 2600 0    50   Input ~ 0
MOTOR_SENSE
Wire Wire Line
	3250 750  3250 1025
$Comp
L roboy_sno-rescue:C-Device C4
U 1 1 5CD5FA82
P 3050 875
F 0 "C4" H 3165 921 50  0000 L CNN
F 1 "0.1uF" H 3165 830 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 3088 725 50  0001 C CNN
F 3 "~" H 3050 875 50  0001 C CNN
	1    3050 875 
	-1   0    0    1   
$EndComp
$Comp
L roboy_sno-rescue:C-Device C5
U 1 1 5CD5FE9C
P 3450 875
F 0 "C5" H 3565 921 50  0000 L CNN
F 1 "10uF" H 3565 830 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 3488 725 50  0001 C CNN
F 3 "~" H 3450 875 50  0001 C CNN
	1    3450 875 
	1    0    0    -1  
$EndComp
Text GLabel 3450 725  1    50   Input ~ 0
GND
Text GLabel 3050 725  1    50   Input ~ 0
GND
Wire Wire Line
	3050 1025 3250 1025
Connection ~ 3250 1025
Wire Wire Line
	3250 1025 3250 1075
Wire Wire Line
	3250 1025 3450 1025
NoConn ~ 3850 3175
NoConn ~ 3850 3275
NoConn ~ 3850 3375
NoConn ~ 3850 3475
NoConn ~ 3850 3575
$Comp
L Switch:SW_Push SW3
U 1 1 5CD74538
P 4825 2775
F 0 "SW3" H 4825 2700 50  0000 C CNN
F 1 "PULL" H 4825 2900 50  0000 C CNN
F 2 "custom_lib:SW_SPST_KXT3" H 4825 2975 50  0001 C CNN
F 3 "" H 4825 2975 50  0001 C CNN
	1    4825 2775
	-1   0    0    1   
$EndComp
$Comp
L Switch:SW_Push SW4
U 1 1 5CD74687
P 4825 3100
F 0 "SW4" H 4825 3025 50  0000 C CNN
F 1 "RELEASE" H 4825 3225 50  0000 C CNN
F 2 "custom_lib:SW_SPST_KXT3" H 4825 3300 50  0001 C CNN
F 3 "" H 4825 3300 50  0001 C CNN
	1    4825 3100
	-1   0    0    1   
$EndComp
$Comp
L roboy_sno-rescue:R-Device R?
U 1 1 5CD74806
P 5175 2775
AR Path="/5ABCD2F9/5CD74806" Ref="R?"  Part="1" 
AR Path="/5CD74806" Ref="R5"  Part="1" 
F 0 "R5" H 5105 2729 50  0000 R CNN
F 1 "10k" H 5105 2820 50  0000 R CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 5105 2775 50  0001 C CNN
F 3 "~" H 5175 2775 50  0001 C CNN
	1    5175 2775
	0    -1   -1   0   
$EndComp
$Comp
L roboy_sno-rescue:R-Device R?
U 1 1 5CD74908
P 5175 3100
AR Path="/5ABCD2F9/5CD74908" Ref="R?"  Part="1" 
AR Path="/5CD74908" Ref="R6"  Part="1" 
F 0 "R6" H 5105 3054 50  0000 R CNN
F 1 "10k" H 5105 3145 50  0000 R CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 5105 3100 50  0001 C CNN
F 3 "~" H 5175 3100 50  0001 C CNN
	1    5175 3100
	0    -1   -1   0   
$EndComp
Text GLabel 5500 2950 2    50   Input ~ 0
3.3V
Wire Wire Line
	5325 2775 5325 2950
Wire Wire Line
	5325 2950 5500 2950
Wire Wire Line
	5325 2950 5325 3100
Connection ~ 5325 2950
Wire Wire Line
	4625 2775 3850 2775
Wire Wire Line
	3850 2875 4625 2875
Wire Wire Line
	4625 2875 4625 3100
Text GLabel 3850 3075 2    50   Input ~ 0
PWRGOOD
NoConn ~ 2650 2975
NoConn ~ 2650 2875
NoConn ~ 2650 2775
NoConn ~ 2650 2675
NoConn ~ 2650 2575
NoConn ~ 2650 2475
$Comp
L Connector:Conn_01x04_Female J3
U 1 1 5CD5CBBC
P 5625 950
F 0 "J3" H 5653 926 50  0000 L CNN
F 1 "UART" H 5653 835 50  0000 L CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_1x04_P2.54mm_Vertical" H 5625 950 50  0001 C CNN
F 3 "~" H 5625 950 50  0001 C CNN
	1    5625 950 
	1    0    0    -1  
$EndComp
Text GLabel 4700 825  0    50   Input ~ 0
MTDI
Text GLabel 4700 925  0    50   Input ~ 0
MTCK
Text GLabel 4700 1025 0    50   Input ~ 0
MTMS
Text GLabel 4700 1125 0    50   Input ~ 0
MTDO
$Comp
L Connector:Conn_01x06_Female J4
U 1 1 5CD639B2
P 4900 1025
F 0 "J4" H 4928 1001 50  0000 L CNN
F 1 "JTAG" H 4928 910 50  0000 L CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_1x06_P2.54mm_Vertical" H 4900 1025 50  0001 C CNN
F 3 "~" H 4900 1025 50  0001 C CNN
	1    4900 1025
	1    0    0    -1  
$EndComp
Text GLabel 4700 1225 0    50   Input ~ 0
GND
Text GLabel 4700 1325 0    50   Input ~ 0
VDD5V
$EndSCHEMATC

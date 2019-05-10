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
F 2 "Housings_DFN_QFN:DFN-6-1EP_3x3mm_Pitch0.95mm" H 9050 4200 50  0001 C CNN
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
P 10150 4575
F 0 "J5" H 10123 4455 50  0000 R CNN
F 1 "Conn_01x02_Male" H 10123 4546 50  0000 R CNN
F 2 "Pin_Headers:Pin_Header_Angled_1x02_Pitch2.54mm" H 10150 4575 50  0001 C CNN
F 3 "~" H 10150 4575 50  0001 C CNN
	1    10150 4575
	-1   0    0    1   
$EndComp
Text GLabel 9950 4475 0    50   Input ~ 0
VDD5V
Text GLabel 9950 4575 0    50   Input ~ 0
GND
Text GLabel 3250 3875 3    50   Input ~ 0
GND
Wire Wire Line
	8425 1525 8625 1525
$Comp
L roboy_sno-rescue:D_Schottky-Device D?
U 1 1 5C1B4309
P 8275 1525
AR Path="/5ABCD2F9/5C1B4309" Ref="D?"  Part="1" 
AR Path="/5C1B4309" Ref="D2"  Part="1" 
F 0 "D2" H 8275 1741 50  0000 C CNN
F 1 "D_Schottky" H 8275 1650 50  0000 C CNN
F 2 "Diodes_SMD:D_SOD-123F" H 8275 1525 50  0001 C CNN
F 3 "~" H 8275 1525 50  0001 C CNN
	1    8275 1525
	1    0    0    -1  
$EndComp
Text GLabel 8925 925  0    50   Input ~ 0
GND
$Comp
L roboy_sno-rescue:USB_B_Mini-Connector_Specialized J?
U 1 1 5C1B4385
P 8925 1325
AR Path="/5ABCD2F9/5C1B4385" Ref="J?"  Part="1" 
AR Path="/5C1B4385" Ref="J1"  Part="1" 
F 0 "J1" H 8696 1223 50  0000 R CNN
F 1 "USB_B_Mini" H 8696 1314 50  0000 R CNN
F 2 "Connectors_USB:USB_Micro-B_Molex_47346-0001" H 9075 1275 50  0001 C CNN
F 3 "~" H 9075 1275 50  0001 C CNN
	1    8925 1325
	-1   0    0    1   
$EndComp
Text GLabel 3250 1075 1    50   Input ~ 0
3.3V
Text GLabel 8125 1525 0    50   Input ~ 0
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
$Comp
L Connector_Generic:Conn_01x03 J2
U 1 1 5C1CBE50
P 8800 2250
F 0 "J2" H 8880 2292 50  0000 L CNN
F 1 "Conn_01x03" H 8880 2201 50  0000 L CNN
F 2 "Pin_Headers:Pin_Header_Angled_1x03_Pitch2.54mm" H 8800 2250 50  0001 C CNN
F 3 "~" H 8800 2250 50  0001 C CNN
	1    8800 2250
	1    0    0    -1  
$EndComp
Text GLabel 8600 2150 0    50   Input ~ 0
GND
Text GLabel 8600 2250 0    50   Input ~ 0
VDD5V
Text GLabel 8600 2350 0    50   Input ~ 0
PWM
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
NoConn ~ 8625 1225
NoConn ~ 8625 1325
Wire Wire Line
	9025 925  8925 925 
NoConn ~ 8625 1125
Wire Wire Line
	2650 1575 2400 1575
$Comp
L Connector_Generic:Conn_01x06 J3
U 1 1 5C5444C0
P 5600 1250
F 0 "J3" H 5680 1242 50  0000 L CNN
F 1 "Conn_01x06" H 5680 1151 50  0000 L CNN
F 2 "custom_lib:TE-Connectivity_Micro-Match_connector_02x03_Pitch_1.27mm" H 5600 1250 50  0001 C CNN
F 3 "~" H 5600 1250 50  0001 C CNN
	1    5600 1250
	1    0    0    -1  
$EndComp
Text GLabel 5400 1550 0    50   Input ~ 0
RTS
Text GLabel 5400 1450 0    50   Input ~ 0
DTR
Text GLabel 5400 1050 0    50   Input ~ 0
VDD5V
Text GLabel 5400 1150 0    50   Input ~ 0
GND
Text GLabel 3850 1375 2    50   Input ~ 0
TXD
Text GLabel 3850 1575 2    50   Input ~ 0
RXD
Text GLabel 5400 1250 0    50   Input ~ 0
TXD
Text GLabel 5400 1350 0    50   Input ~ 0
RXD
Text GLabel 5000 2100 0    50   Input ~ 0
ID0
Text GLabel 6100 2300 2    50   Input ~ 0
3.3V
Text GLabel 2075 950  1    50   Input ~ 0
GND
$Comp
L roboy_sno-rescue:C-Device C?
U 1 1 5CD59FD3
P 2075 1100
F 0 "C?" H 2190 1146 50  0000 L CNN
F 1 "0.1uF" H 2190 1055 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 2113 950 50  0001 C CNN
F 3 "~" H 2075 1100 50  0001 C CNN
	1    2075 1100
	1    0    0    -1  
$EndComp
Wire Wire Line
	2075 1250 2075 1275
$Comp
L Switch:SW_Push SW?
U 1 1 5CD5A84F
P 2450 1075
F 0 "SW?" V 2404 1223 50  0000 L CNN
F 1 "RESET" V 2495 1223 50  0000 L CNN
F 2 "" H 2450 1275 50  0001 C CNN
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
L Switch:SW_Push SW?
U 1 1 5CD5B563
P 3850 1075
F 0 "SW?" H 3850 1000 50  0000 C CNN
F 1 "RESET" H 3850 1200 50  0000 C CNN
F 2 "" H 3850 1275 50  0001 C CNN
F 3 "" H 3850 1275 50  0001 C CNN
	1    3850 1075
	0    1    1    0   
$EndComp
Text GLabel 3850 875  1    50   Input ~ 0
GND
$Comp
L Switch:SW_DIP_x05 SW?
U 1 1 5CD5C24B
P 5300 2300
F 0 "SW?" H 5300 2767 50  0000 C CNN
F 1 "SW_DIP_x05" H 5300 2676 50  0000 C CNN
F 2 "" H 5300 2300 50  0001 C CNN
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
AR Path="/5CD5D033" Ref="R?"  Part="1" 
F 0 "R?" V 5750 2375 50  0000 R CNN
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
AR Path="/5CD5D777" Ref="R?"  Part="1" 
F 0 "R?" V 5750 2275 50  0000 R CNN
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
AR Path="/5CD5D7B1" Ref="R?"  Part="1" 
F 0 "R?" V 5750 2175 50  0000 R CNN
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
AR Path="/5CD5D7EB" Ref="R?"  Part="1" 
F 0 "R?" V 5750 2075 50  0000 R CNN
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
AR Path="/5CD5D827" Ref="R?"  Part="1" 
F 0 "R?" V 5750 1975 50  0000 R CNN
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
L RF_Module:ESP32-WROOM-32 U?
U 1 1 5CD5F722
P 3250 2475
F 0 "U?" H 3250 2625 50  0000 C CNN
F 1 "ESP32-WROOM-32" H 3175 1675 50  0000 C CNN
F 2 "RF_Module:ESP32-WROOM-32" H 3250 975 50  0001 C CNN
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
AR Path="/5CD64770" Ref="R?"  Part="1" 
F 0 "R?" V 4000 1775 50  0000 R CNN
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
AR Path="/5CD65C84" Ref="R?"  Part="1" 
F 0 "R?" V 4000 1875 50  0000 R CNN
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
AR Path="/5CD66330" Ref="R?"  Part="1" 
F 0 "R?" V 4000 1975 50  0000 R CNN
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
AR Path="/5CD66337" Ref="R?"  Part="1" 
F 0 "R?" V 4000 2075 50  0000 R CNN
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
L LED:SK6812 D?
U 1 1 5CD68D53
P 5250 4550
F 0 "D?" H 4925 4400 50  0000 L CNN
F 1 "SK6812" H 4850 4800 50  0000 L CNN
F 2 "custom_lib:LED_WS2812B-PLCC4_3.5x3.5" H 5300 4250 50  0001 L TNN
F 3 "https://cdn-shop.adafruit.com/product-files/1138/SK6812+LED+datasheet+.pdf" H 5350 4175 50  0001 L TNN
	1    5250 4550
	1    0    0    -1  
$EndComp
$Comp
L LED:SK6812 D?
U 1 1 5CD68DC5
P 5950 4550
F 0 "D?" H 5625 4400 50  0000 L CNN
F 1 "SK6812" H 5550 4800 50  0000 L CNN
F 2 "custom_lib:LED_WS2812B-PLCC4_3.5x3.5" H 6000 4250 50  0001 L TNN
F 3 "https://cdn-shop.adafruit.com/product-files/1138/SK6812+LED+datasheet+.pdf" H 6050 4175 50  0001 L TNN
	1    5950 4550
	1    0    0    -1  
$EndComp
$Comp
L LED:SK6812 D?
U 1 1 5CD69702
P 6650 4550
F 0 "D?" H 6325 4400 50  0000 L CNN
F 1 "SK6812" H 6250 4800 50  0000 L CNN
F 2 "custom_lib:LED_WS2812B-PLCC4_3.5x3.5" H 6700 4250 50  0001 L TNN
F 3 "https://cdn-shop.adafruit.com/product-files/1138/SK6812+LED+datasheet+.pdf" H 6750 4175 50  0001 L TNN
	1    6650 4550
	1    0    0    -1  
$EndComp
$Comp
L LED:SK6812 D?
U 1 1 5CD69708
P 7350 4550
F 0 "D?" H 7025 4400 50  0000 L CNN
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
L roboy_sno-rescue:C-Device C?
U 1 1 5CD76F57
P 7000 4825
F 0 "C?" H 7115 4871 50  0000 L CNN
F 1 "0.1u" H 7115 4780 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 7038 4675 50  0001 C CNN
F 3 "~" H 7000 4825 50  0001 C CNN
	1    7000 4825
	1    0    0    -1  
$EndComp
$Comp
L roboy_sno-rescue:C-Device C?
U 1 1 5CD772E8
P 6300 4825
F 0 "C?" H 6415 4871 50  0000 L CNN
F 1 "0.1u" H 6415 4780 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 6338 4675 50  0001 C CNN
F 3 "~" H 6300 4825 50  0001 C CNN
	1    6300 4825
	1    0    0    -1  
$EndComp
$Comp
L roboy_sno-rescue:C-Device C?
U 1 1 5CD7735A
P 5600 4825
F 0 "C?" H 5715 4871 50  0000 L CNN
F 1 "0.1u" H 5715 4780 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 5638 4675 50  0001 C CNN
F 3 "~" H 5600 4825 50  0001 C CNN
	1    5600 4825
	1    0    0    -1  
$EndComp
$Comp
L roboy_sno-rescue:C-Device C?
U 1 1 5CD773D6
P 4900 4825
F 0 "C?" H 5015 4871 50  0000 L CNN
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
$EndSCHEMATC

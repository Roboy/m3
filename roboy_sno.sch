EESchema Schematic File Version 4
EELAYER 30 0
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
$Comp
L roboy_sno-rescue:C-Device-roboy_sno-rescue C3
U 1 1 5ABD740F
P 8850 1550
F 0 "C3" H 8965 1596 50  0000 L CNN
F 1 "10uF" H 8965 1505 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 8888 1400 50  0001 C CNN
F 3 "~" H 8850 1550 50  0001 C CNN
	1    8850 1550
	1    0    0    -1  
$EndComp
$Comp
L roboy_sno-rescue:C-Device-roboy_sno-rescue C2
U 1 1 5ABD7467
P 7450 1550
F 0 "C2" H 7565 1596 50  0000 L CNN
F 1 "10uF" H 7565 1505 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 7488 1400 50  0001 C CNN
F 3 "~" H 7450 1550 50  0001 C CNN
	1    7450 1550
	1    0    0    -1  
$EndComp
$Comp
L roboy_sno-rescue:LD39200-roboy_sno-roboy_sno-rescue U1
U 1 1 5AB658D6
P 8200 1800
F 0 "U1" H 8150 2125 50  0000 C CNN
F 1 "LD39200" H 8150 2034 50  0000 C CNN
F 2 "Package_DFN_QFN:DFN-6-1EP_3x3mm_P0.95mm_EP1.7x2.6mm" H 8200 1800 50  0001 C CNN
F 3 "" H 8200 1800 50  0001 C CNN
	1    8200 1800
	1    0    0    -1  
$EndComp
Wire Wire Line
	7450 1700 7700 1700
Wire Wire Line
	8600 1700 8850 1700
Wire Wire Line
	9050 1300 8850 1300
Wire Wire Line
	7450 1300 7450 1400
Wire Wire Line
	8850 1400 8850 1300
Connection ~ 8850 1300
Wire Wire Line
	8850 1300 7450 1300
Wire Wire Line
	7700 1800 7450 1800
Wire Wire Line
	7450 1800 7450 1700
Connection ~ 7450 1700
Wire Wire Line
	7600 1900 7700 1900
Wire Wire Line
	7450 1700 7200 1700
$Comp
L roboy_sno-rescue:Conn_01x02_Male-Connector-roboy_sno-rescue J5
U 1 1 5B881020
P 8500 950
F 0 "J5" H 8473 830 50  0000 R CNN
F 1 "Conn_01x02_Male" H 8473 921 50  0000 R CNN
F 2 "Pin_Headers:Pin_Header_Angled_1x02_Pitch2.54mm" H 8500 950 50  0001 C CNN
F 3 "~" H 8500 950 50  0001 C CNN
	1    8500 950 
	-1   0    0    1   
$EndComp
Wire Wire Line
	8975 1700 8875 1700
Connection ~ 8850 1700
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
Text GLabel 4250 4550 0    50   Input ~ 0
NEOPX
Wire Wire Line
	8875 1700 8875 1800
Wire Wire Line
	8875 1800 8600 1800
Connection ~ 8875 1700
Wire Wire Line
	8875 1700 8850 1700
$Comp
L roboy_sno-rescue:R-Device-roboy_sno-rescue R?
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
Wire Wire Line
	1625 1275 1625 1250
Text GLabel 3850 1375 2    50   Input ~ 0
TXD
Text GLabel 3850 1575 2    50   Input ~ 0
RXD
Text GLabel 5425 1050 0    50   Input ~ 0
TXD
Text GLabel 5425 1150 0    50   Input ~ 0
RXD
$Comp
L roboy_sno-rescue:C-Device-roboy_sno-rescue C1
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
F 2 "custom_lib:PTS815-SJK" H 2450 1275 50  0001 C CNN
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
$Comp
L Switch:SW_Push SW2
U 1 1 5CD5B563
P 3850 1075
F 0 "SW2" H 3850 1000 50  0000 C CNN
F 1 "BOOT" H 3850 1200 50  0000 C CNN
F 2 "custom_lib:PTS815-SJK" H 3850 1275 50  0001 C CNN
F 3 "" H 3850 1275 50  0001 C CNN
	1    3850 1075
	0    1    1    0   
$EndComp
Text GLabel 3850 1475 2    50   Input ~ 0
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
Text GLabel 3850 2675 2    50   Input ~ 0
MOTOR_SENSE
Wire Wire Line
	4550 4250 4900 4250
Wire Wire Line
	4550 4125 4550 4250
Connection ~ 4550 4250
$Comp
L roboy_sno-rescue:C-Device-roboy_sno-rescue C6
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
	4900 4675 4900 4250
NoConn ~ 2650 1475
$Comp
L Connector:Conn_01x04_Male J2
U 1 1 5CD5B969
P 7025 1050
F 0 "J2" H 6998 930 50  0000 R CNN
F 1 "Conn_01x04_Male" H 6998 1021 50  0000 R CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x04_P2.54mm_Vertical" H 7025 1050 50  0001 C CNN
F 3 "~" H 7025 1050 50  0001 C CNN
	1    7025 1050
	-1   0    0    1   
$EndComp
Text GLabel 6825 1050 0    50   Input ~ 0
MOTOR
Text GLabel 6825 1150 0    50   Input ~ 0
MOTOR_SENSE
Wire Wire Line
	3250 750  3250 1025
$Comp
L roboy_sno-rescue:C-Device-roboy_sno-rescue C4
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
L roboy_sno-rescue:C-Device-roboy_sno-rescue C5
U 1 1 5CD5FE9C
P 3450 875
F 0 "C5" H 3565 921 50  0000 L CNN
F 1 "10uF" H 3565 830 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 3488 725 50  0001 C CNN
F 3 "~" H 3450 875 50  0001 C CNN
	1    3450 875 
	1    0    0    -1  
$EndComp
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
F 2 "custom_lib:PTS815-SJK" H 4825 2975 50  0001 C CNN
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
F 2 "custom_lib:PTS815-SJK" H 4825 3300 50  0001 C CNN
F 3 "" H 4825 3300 50  0001 C CNN
	1    4825 3100
	-1   0    0    1   
$EndComp
Wire Wire Line
	4625 2775 3850 2775
Wire Wire Line
	3850 2875 4625 2875
Wire Wire Line
	4625 2875 4625 3100
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
$Comp
L power:+5V #PWR0101
U 1 1 5DD8518A
P 4550 4125
F 0 "#PWR0101" H 4550 3975 50  0001 C CNN
F 1 "+5V" H 4565 4298 50  0000 C CNN
F 2 "" H 4550 4125 50  0001 C CNN
F 3 "" H 4550 4125 50  0001 C CNN
	1    4550 4125
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0102
U 1 1 5DD8599E
P 5425 850
F 0 "#PWR0102" H 5425 700 50  0001 C CNN
F 1 "+5V" V 5440 978 50  0000 L CNN
F 2 "" H 5425 850 50  0001 C CNN
F 3 "" H 5425 850 50  0001 C CNN
	1    5425 850 
	0    -1   -1   0   
$EndComp
$Comp
L power:+5V #PWR0103
U 1 1 5DD863D7
P 8975 1700
F 0 "#PWR0103" H 8975 1550 50  0001 C CNN
F 1 "+5V" V 8990 1828 50  0000 L CNN
F 2 "" H 8975 1700 50  0001 C CNN
F 3 "" H 8975 1700 50  0001 C CNN
	1    8975 1700
	0    1    1    0   
$EndComp
NoConn ~ 3850 2075
NoConn ~ 3850 2175
NoConn ~ 4850 4550
$Comp
L power:+5V #PWR0104
U 1 1 5DDB5EDF
P 6825 950
F 0 "#PWR0104" H 6825 800 50  0001 C CNN
F 1 "+5V" V 6840 1078 50  0000 L CNN
F 2 "" H 6825 950 50  0001 C CNN
F 3 "" H 6825 950 50  0001 C CNN
	1    6825 950 
	0    -1   -1   0   
$EndComp
$Comp
L power:+5V #PWR0105
U 1 1 5DDB6303
P 8300 850
F 0 "#PWR0105" H 8300 700 50  0001 C CNN
F 1 "+5V" V 8315 978 50  0000 L CNN
F 2 "" H 8300 850 50  0001 C CNN
F 3 "" H 8300 850 50  0001 C CNN
	1    8300 850 
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR0106
U 1 1 5DDC3139
P 3250 3875
F 0 "#PWR0106" H 3250 3625 50  0001 C CNN
F 1 "GND" H 3255 3702 50  0000 C CNN
F 2 "" H 3250 3875 50  0001 C CNN
F 3 "" H 3250 3875 50  0001 C CNN
	1    3250 3875
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0107
U 1 1 5DDC3864
P 4550 5075
F 0 "#PWR0107" H 4550 4825 50  0001 C CNN
F 1 "GND" H 4555 4902 50  0000 C CNN
F 2 "" H 4550 5075 50  0001 C CNN
F 3 "" H 4550 5075 50  0001 C CNN
	1    4550 5075
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0108
U 1 1 5DDC4067
P 7600 1900
F 0 "#PWR0108" H 7600 1650 50  0001 C CNN
F 1 "GND" H 7605 1727 50  0000 C CNN
F 2 "" H 7600 1900 50  0001 C CNN
F 3 "" H 7600 1900 50  0001 C CNN
	1    7600 1900
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0109
U 1 1 5DDC46B4
P 9050 1300
F 0 "#PWR0109" H 9050 1050 50  0001 C CNN
F 1 "GND" V 9055 1172 50  0000 R CNN
F 2 "" H 9050 1300 50  0001 C CNN
F 3 "" H 9050 1300 50  0001 C CNN
	1    9050 1300
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR0110
U 1 1 5DDC5319
P 8300 950
F 0 "#PWR0110" H 8300 700 50  0001 C CNN
F 1 "GND" V 8305 822 50  0000 R CNN
F 2 "" H 8300 950 50  0001 C CNN
F 3 "" H 8300 950 50  0001 C CNN
	1    8300 950 
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0111
U 1 1 5DDC58C4
P 6825 850
F 0 "#PWR0111" H 6825 600 50  0001 C CNN
F 1 "GND" V 6830 722 50  0000 R CNN
F 2 "" H 6825 850 50  0001 C CNN
F 3 "" H 6825 850 50  0001 C CNN
	1    6825 850 
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0112
U 1 1 5DDC5D27
P 5425 950
F 0 "#PWR0112" H 5425 700 50  0001 C CNN
F 1 "GND" V 5430 822 50  0000 R CNN
F 2 "" H 5425 950 50  0001 C CNN
F 3 "" H 5425 950 50  0001 C CNN
	1    5425 950 
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0113
U 1 1 5DDC6BDA
P 2075 950
F 0 "#PWR0113" H 2075 700 50  0001 C CNN
F 1 "GND" H 2080 777 50  0000 C CNN
F 2 "" H 2075 950 50  0001 C CNN
F 3 "" H 2075 950 50  0001 C CNN
	1    2075 950 
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR0114
U 1 1 5DDC724F
P 2450 875
F 0 "#PWR0114" H 2450 625 50  0001 C CNN
F 1 "GND" H 2455 702 50  0000 C CNN
F 2 "" H 2450 875 50  0001 C CNN
F 3 "" H 2450 875 50  0001 C CNN
	1    2450 875 
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR0115
U 1 1 5DDC7690
P 3050 725
F 0 "#PWR0115" H 3050 475 50  0001 C CNN
F 1 "GND" H 3055 552 50  0000 C CNN
F 2 "" H 3050 725 50  0001 C CNN
F 3 "" H 3050 725 50  0001 C CNN
	1    3050 725 
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR0116
U 1 1 5DDC7B04
P 3450 725
F 0 "#PWR0116" H 3450 475 50  0001 C CNN
F 1 "GND" H 3455 552 50  0000 C CNN
F 2 "" H 3450 725 50  0001 C CNN
F 3 "" H 3450 725 50  0001 C CNN
	1    3450 725 
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR0117
U 1 1 5DDC7EE2
P 3850 875
F 0 "#PWR0117" H 3850 625 50  0001 C CNN
F 1 "GND" H 3855 702 50  0000 C CNN
F 2 "" H 3850 875 50  0001 C CNN
F 3 "" H 3850 875 50  0001 C CNN
	1    3850 875 
	-1   0    0    1   
$EndComp
$Comp
L power:+3.3V #PWR0119
U 1 1 5DDCA88E
P 7200 1700
F 0 "#PWR0119" H 7200 1550 50  0001 C CNN
F 1 "+3.3V" V 7215 1828 50  0000 L CNN
F 2 "" H 7200 1700 50  0001 C CNN
F 3 "" H 7200 1700 50  0001 C CNN
	1    7200 1700
	0    -1   -1   0   
$EndComp
$Comp
L power:+3.3V #PWR0120
U 1 1 5DDCB475
P 3250 750
F 0 "#PWR0120" H 3250 600 50  0001 C CNN
F 1 "+3.3V" H 3265 923 50  0000 C CNN
F 2 "" H 3250 750 50  0001 C CNN
F 3 "" H 3250 750 50  0001 C CNN
	1    3250 750 
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR0121
U 1 1 5DDCBD60
P 1625 950
F 0 "#PWR0121" H 1625 800 50  0001 C CNN
F 1 "+3.3V" H 1640 1123 50  0000 C CNN
F 2 "" H 1625 950 50  0001 C CNN
F 3 "" H 1625 950 50  0001 C CNN
	1    1625 950 
	1    0    0    -1  
$EndComp
NoConn ~ 3850 2975
$Comp
L Connector:Conn_01x06_Female J1
U 1 1 5DDF6547
P 5525 2000
F 0 "J1" H 5553 1976 50  0000 L CNN
F 1 "200AMA16R" H 5553 1885 50  0000 L CNN
F 2 "custom_lib:200AMA16R" H 5525 2000 50  0001 C CNN
F 3 "~" H 5525 2000 50  0001 C CNN
	1    5525 2000
	1    0    0    -1  
$EndComp
NoConn ~ 3850 2475
Text GLabel 5325 1800 0    50   Input ~ 0
ID0
Text GLabel 5325 2000 0    50   Input ~ 0
ID2
Text GLabel 5325 2100 0    50   Input ~ 0
ID1
Text GLabel 5325 2300 0    50   Input ~ 0
ID3
$Comp
L power:GND #PWR0124
U 1 1 5DDFAD47
P 5325 1900
F 0 "#PWR0124" H 5325 1650 50  0001 C CNN
F 1 "GND" V 5330 1772 50  0000 R CNN
F 2 "" H 5325 1900 50  0001 C CNN
F 3 "" H 5325 1900 50  0001 C CNN
	1    5325 1900
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0125
U 1 1 5DDFB1A2
P 5325 2200
F 0 "#PWR0125" H 5325 1950 50  0001 C CNN
F 1 "GND" V 5330 2072 50  0000 R CNN
F 2 "" H 5325 2200 50  0001 C CNN
F 3 "" H 5325 2200 50  0001 C CNN
	1    5325 2200
	0    1    1    0   
$EndComp
Text GLabel 3850 1675 2    50   Input ~ 0
ID0
Text GLabel 3850 1775 2    50   Input ~ 0
ID1
Text GLabel 3850 2275 2    50   Input ~ 0
ID2
Text GLabel 3850 2375 2    50   Input ~ 0
ID3
NoConn ~ 2650 1575
$Comp
L Connector:Conn_01x06_Female J4
U 1 1 5DE03A3E
P 7625 2975
F 0 "J4" H 7653 2951 50  0000 L CNN
F 1 "tcut1350" H 7653 2860 50  0000 L CNN
F 2 "custom_lib:tcut1350x01" H 7625 2975 50  0001 C CNN
F 3 "~" H 7625 2975 50  0001 C CNN
	1    7625 2975
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0122
U 1 1 5DE0804E
P 6600 2775
F 0 "#PWR0122" H 6600 2525 50  0001 C CNN
F 1 "GND" V 6605 2647 50  0000 R CNN
F 2 "" H 6600 2775 50  0001 C CNN
F 3 "" H 6600 2775 50  0001 C CNN
	1    6600 2775
	0    1    1    0   
$EndComp
$Comp
L Device:R R1
U 1 1 5DE0885C
P 6750 2775
F 0 "R1" V 6543 2775 50  0000 C CNN
F 1 "1k" V 6634 2775 50  0000 C CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 6680 2775 50  0001 C CNN
F 3 "~" H 6750 2775 50  0001 C CNN
	1    6750 2775
	0    1    1    0   
$EndComp
$Comp
L Device:R R2
U 1 1 5DE0BE14
P 6750 3100
F 0 "R2" V 6957 3100 50  0000 C CNN
F 1 "1k" V 6866 3100 50  0000 C CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 6680 3100 50  0001 C CNN
F 3 "~" H 6750 3100 50  0001 C CNN
	1    6750 3100
	0    -1   -1   0   
$EndComp
Wire Wire Line
	6600 3100 6600 2775
Connection ~ 6600 2775
Wire Wire Line
	6900 2775 7075 2775
Wire Wire Line
	7425 2875 7275 2875
Wire Wire Line
	6900 2875 6900 3100
$Comp
L power:+5V #PWR0123
U 1 1 5DE0EC7D
P 7425 2975
F 0 "#PWR0123" H 7425 2825 50  0001 C CNN
F 1 "+5V" V 7440 3103 50  0000 L CNN
F 2 "" H 7425 2975 50  0001 C CNN
F 3 "" H 7425 2975 50  0001 C CNN
	1    7425 2975
	0    -1   -1   0   
$EndComp
NoConn ~ 7425 3175
$Comp
L power:GND #PWR0126
U 1 1 5DE0FD84
P 7425 3275
F 0 "#PWR0126" H 7425 3025 50  0001 C CNN
F 1 "GND" V 7430 3147 50  0000 R CNN
F 2 "" H 7425 3275 50  0001 C CNN
F 3 "" H 7425 3275 50  0001 C CNN
	1    7425 3275
	0    1    1    0   
$EndComp
$Comp
L Device:R R3
U 1 1 5DE103FF
P 6925 3550
F 0 "R3" V 7132 3550 50  0000 C CNN
F 1 "1k" V 7041 3550 50  0000 C CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 6855 3550 50  0001 C CNN
F 3 "~" H 6925 3550 50  0001 C CNN
	1    6925 3550
	0    -1   -1   0   
$EndComp
$Comp
L power:+5V #PWR0127
U 1 1 5DE10BC0
P 6775 3550
F 0 "#PWR0127" H 6775 3400 50  0001 C CNN
F 1 "+5V" V 6790 3678 50  0000 L CNN
F 2 "" H 6775 3550 50  0001 C CNN
F 3 "" H 6775 3550 50  0001 C CNN
	1    6775 3550
	0    -1   -1   0   
$EndComp
Wire Wire Line
	7425 3075 7075 3075
Wire Wire Line
	7075 3075 7075 3550
Text GLabel 7075 2650 1    50   Input ~ 0
E0
Text GLabel 7275 2650 1    50   Input ~ 0
E1
Wire Wire Line
	7075 2650 7075 2775
Connection ~ 7075 2775
Wire Wire Line
	7075 2775 7425 2775
Wire Wire Line
	7275 2650 7275 2875
Connection ~ 7275 2875
Wire Wire Line
	7275 2875 6900 2875
Text GLabel 3850 1875 2    50   Input ~ 0
E0
Text GLabel 3850 1975 2    50   Input ~ 0
E1
$Comp
L power:GND #PWR0118
U 1 1 5DDA4F80
P 5025 2775
F 0 "#PWR0118" H 5025 2525 50  0001 C CNN
F 1 "GND" V 5030 2647 50  0000 R CNN
F 2 "" H 5025 2775 50  0001 C CNN
F 3 "" H 5025 2775 50  0001 C CNN
	1    5025 2775
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR0128
U 1 1 5DDA7291
P 5025 3100
F 0 "#PWR0128" H 5025 2850 50  0001 C CNN
F 1 "GND" V 5030 2972 50  0000 R CNN
F 2 "" H 5025 3100 50  0001 C CNN
F 3 "" H 5025 3100 50  0001 C CNN
	1    5025 3100
	0    -1   -1   0   
$EndComp
NoConn ~ 8600 1900
NoConn ~ 3850 3075
$Comp
L Mechanical:MountingHole H1
U 1 1 5DDBEBB0
P 8650 2575
F 0 "H1" H 8750 2621 50  0000 L CNN
F 1 "MountingHole" H 8750 2530 50  0000 L CNN
F 2 "MountingHole:MountingHole_2.2mm_M2_Pad" H 8650 2575 50  0001 C CNN
F 3 "~" H 8650 2575 50  0001 C CNN
	1    8650 2575
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H2
U 1 1 5DDC1C0E
P 8650 2800
F 0 "H2" H 8750 2846 50  0000 L CNN
F 1 "MountingHole" H 8750 2755 50  0000 L CNN
F 2 "MountingHole:MountingHole_2.2mm_M2_Pad" H 8650 2800 50  0001 C CNN
F 3 "~" H 8650 2800 50  0001 C CNN
	1    8650 2800
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H3
U 1 1 5DDC1E70
P 8650 3600
F 0 "H3" H 8750 3646 50  0000 L CNN
F 1 "LABEL" H 8750 3555 50  0000 L CNN
F 2 "custom_lib:R1_ear_silk_5.5mm" H 8650 3600 50  0001 C CNN
F 3 "~" H 8650 3600 50  0001 C CNN
	1    8650 3600
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H4
U 1 1 5DDC2316
P 8650 3825
F 0 "H4" H 8750 3871 50  0000 L CNN
F 1 "LABEL" H 8750 3780 50  0000 L CNN
F 2 "custom_lib:R1_eyes_mask_5.5mm" H 8650 3825 50  0001 C CNN
F 3 "~" H 8650 3825 50  0001 C CNN
	1    8650 3825
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H5
U 1 1 5DDC2626
P 8650 4050
F 0 "H5" H 8750 4096 50  0000 L CNN
F 1 "LABEL" H 8750 4005 50  0000 L CNN
F 2 "custom_lib:R1_face_mask_5.5mm" H 8650 4050 50  0001 C CNN
F 3 "~" H 8650 4050 50  0001 C CNN
	1    8650 4050
	1    0    0    -1  
$EndComp
$EndSCHEMATC

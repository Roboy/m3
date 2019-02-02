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
Text GLabel 4050 3450 2    50   Input ~ 0
VDD5V
Text GLabel 4125 3050 2    50   Input ~ 0
GND
$Comp
L roboy_sno-rescue:C-Device C3
U 1 1 5ABD740F
P 3925 3300
F 0 "C3" H 4040 3346 50  0000 L CNN
F 1 "10uF" H 4040 3255 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 3963 3150 50  0001 C CNN
F 3 "~" H 3925 3300 50  0001 C CNN
	1    3925 3300
	1    0    0    -1  
$EndComp
$Comp
L roboy_sno-rescue:C-Device C2
U 1 1 5ABD7467
P 2525 3300
F 0 "C2" H 2640 3346 50  0000 L CNN
F 1 "10uF" H 2640 3255 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 2563 3150 50  0001 C CNN
F 3 "~" H 2525 3300 50  0001 C CNN
	1    2525 3300
	1    0    0    -1  
$EndComp
$Comp
L roboy_sno-rescue:LD39200-roboy_sno U1
U 1 1 5AB658D6
P 3275 3550
F 0 "U1" H 3225 3875 50  0000 C CNN
F 1 "LD39200" H 3225 3784 50  0000 C CNN
F 2 "Housings_DFN_QFN:DFN-6-1EP_3x3mm_Pitch0.95mm" H 3275 3550 50  0001 C CNN
F 3 "" H 3275 3550 50  0001 C CNN
	1    3275 3550
	1    0    0    -1  
$EndComp
Wire Wire Line
	2525 3450 2775 3450
Wire Wire Line
	3675 3450 3925 3450
Wire Wire Line
	4125 3050 3925 3050
Wire Wire Line
	2525 3050 2525 3150
Wire Wire Line
	3925 3150 3925 3050
Connection ~ 3925 3050
Wire Wire Line
	3925 3050 2525 3050
Text GLabel 2275 3450 0    50   Input ~ 0
3.3V
Wire Wire Line
	2775 3550 2525 3550
Wire Wire Line
	2525 3550 2525 3450
Connection ~ 2525 3450
Text GLabel 2675 3650 0    50   Input ~ 0
GND
Wire Wire Line
	2675 3650 2775 3650
Wire Wire Line
	2525 3450 2275 3450
$Comp
L roboy_sno-rescue:Conn_01x02_Male-Connector J5
U 1 1 5B881020
P 4375 3925
F 0 "J5" H 4348 3805 50  0000 R CNN
F 1 "Conn_01x02_Male" H 4348 3896 50  0000 R CNN
F 2 "Pin_Headers:Pin_Header_Angled_1x02_Pitch2.54mm" H 4375 3925 50  0001 C CNN
F 3 "~" H 4375 3925 50  0001 C CNN
	1    4375 3925
	-1   0    0    1   
$EndComp
Text GLabel 4175 3825 0    50   Input ~ 0
VDD5V
Text GLabel 4175 3925 0    50   Input ~ 0
GND
$Comp
L roboy_sno-rescue:R-Device R?
U 1 1 5C1B42F3
P 8825 1875
AR Path="/5ABCD2F9/5C1B42F3" Ref="R?"  Part="1" 
AR Path="/5C1B42F3" Ref="R7"  Part="1" 
F 0 "R7" H 8755 1829 50  0000 R CNN
F 1 "10k" H 8755 1920 50  0000 R CNN
F 2 "Resistors_SMD:R_0402" V 8755 1875 50  0001 C CNN
F 3 "~" H 8825 1875 50  0001 C CNN
	1    8825 1875
	0    -1   -1   0   
$EndComp
$Comp
L roboy_sno-rescue:R-Device R?
U 1 1 5C1B42FA
P 8825 1175
AR Path="/5ABCD2F9/5C1B42FA" Ref="R?"  Part="1" 
AR Path="/5C1B42FA" Ref="R6"  Part="1" 
F 0 "R6" H 8755 1129 50  0000 R CNN
F 1 "10k" H 8755 1220 50  0000 R CNN
F 2 "Resistors_SMD:R_0402" V 8755 1175 50  0001 C CNN
F 3 "~" H 8825 1175 50  0001 C CNN
	1    8825 1175
	0    -1   -1   0   
$EndComp
Text GLabel 4050 2375 2    50   Input ~ 0
GND
Wire Wire Line
	6525 1525 6725 1525
$Comp
L roboy_sno-rescue:D_Schottky-Device D?
U 1 1 5C1B4309
P 6375 1525
AR Path="/5ABCD2F9/5C1B4309" Ref="D?"  Part="1" 
AR Path="/5C1B4309" Ref="D2"  Part="1" 
F 0 "D2" H 6375 1741 50  0000 C CNN
F 1 "D_Schottky" H 6375 1650 50  0000 C CNN
F 2 "Diodes_SMD:D_SOD-123F" H 6375 1525 50  0001 C CNN
F 3 "~" H 6375 1525 50  0001 C CNN
	1    6375 1525
	1    0    0    -1  
$EndComp
Text GLabel 7025 925  0    50   Input ~ 0
GND
$Comp
L roboy_sno-rescue:USB_B_Mini-Connector_Specialized J?
U 1 1 5C1B4385
P 7025 1325
AR Path="/5ABCD2F9/5C1B4385" Ref="J?"  Part="1" 
AR Path="/5C1B4385" Ref="J1"  Part="1" 
F 0 "J1" H 6796 1223 50  0000 R CNN
F 1 "USB_B_Mini" H 6796 1314 50  0000 R CNN
F 2 "Connectors_USB:USB_Micro-B_Molex_47346-0001" H 7175 1275 50  0001 C CNN
F 3 "~" H 7175 1275 50  0001 C CNN
	1    7025 1325
	-1   0    0    1   
$EndComp
Text GLabel 4050 1075 2    50   Input ~ 0
3.3V
$Comp
L roboy_sno-rescue:Q_DUAL_NPN_NPN_E1B1C2E2B2C1-Device Q?
U 1 1 5C1B439B
P 9475 1175
AR Path="/5ABCD2F9/5C1B439B" Ref="Q?"  Part="1" 
AR Path="/5C1B439B" Ref="Q1"  Part="1" 
F 0 "Q1" H 9666 1221 50  0000 L CNN
F 1 "Q_DUAL_NPN_NPN_E1B1C2E2B2C1" H 9666 1130 50  0000 L CNN
F 2 "TO_SOT_Packages_SMD:SOT-363_SC-70-6" H 9675 1275 50  0001 C CNN
F 3 "~" H 9475 1175 50  0001 C CNN
	1    9475 1175
	1    0    0    -1  
$EndComp
$Comp
L roboy_sno-rescue:Q_DUAL_NPN_NPN_E1B1C2E2B2C1-Device Q?
U 2 1 5C1B43A2
P 9475 1875
AR Path="/5ABCD2F9/5C1B43A2" Ref="Q?"  Part="2" 
AR Path="/5C1B43A2" Ref="Q1"  Part="2" 
F 0 "Q1" H 9666 1829 50  0000 L CNN
F 1 "Q_DUAL_NPN_NPN_E1B1C2E2B2C1" H 9666 1920 50  0000 L CNN
F 2 "TO_SOT_Packages_SMD:SOT-363_SC-70-6" H 9675 1975 50  0001 C CNN
F 3 "~" H 9475 1875 50  0001 C CNN
	2    9475 1875
	1    0    0    1   
$EndComp
Text GLabel 8225 1175 0    50   Input ~ 0
RTS
Text GLabel 8225 1875 0    50   Input ~ 0
DTR
Wire Wire Line
	8225 1175 8475 1175
Wire Wire Line
	8975 1175 9275 1175
Wire Wire Line
	9275 1875 8975 1875
Wire Wire Line
	8675 1875 8525 1875
Wire Wire Line
	8475 1175 8475 1625
Wire Wire Line
	8475 1625 9575 1625
Wire Wire Line
	9575 1625 9575 1675
Connection ~ 8475 1175
Wire Wire Line
	8475 1175 8675 1175
Wire Wire Line
	9575 1375 9575 1475
Wire Wire Line
	9575 1475 8525 1475
Wire Wire Line
	8525 1475 8525 1875
Connection ~ 8525 1875
Wire Wire Line
	8525 1875 8225 1875
Text GLabel 9275 775  0    50   Input ~ 0
3.3V
Text GLabel 9275 2275 0    50   Input ~ 0
3.3V
$Comp
L roboy_sno-rescue:R-Device R?
U 1 1 5C1B43BB
P 9425 775
AR Path="/5ABCD2F9/5C1B43BB" Ref="R?"  Part="1" 
AR Path="/5C1B43BB" Ref="R8"  Part="1" 
F 0 "R8" H 9355 729 50  0000 R CNN
F 1 "10k" H 9355 820 50  0000 R CNN
F 2 "Resistors_SMD:R_0402" V 9355 775 50  0001 C CNN
F 3 "~" H 9425 775 50  0001 C CNN
	1    9425 775 
	0    -1   -1   0   
$EndComp
$Comp
L roboy_sno-rescue:R-Device R?
U 1 1 5C1B43C2
P 9425 2275
AR Path="/5ABCD2F9/5C1B43C2" Ref="R?"  Part="1" 
AR Path="/5C1B43C2" Ref="R9"  Part="1" 
F 0 "R9" H 9355 2229 50  0000 R CNN
F 1 "10k" H 9355 2320 50  0000 R CNN
F 2 "Resistors_SMD:R_0402" V 9355 2275 50  0001 C CNN
F 3 "~" H 9425 2275 50  0001 C CNN
	1    9425 2275
	0    -1   -1   0   
$EndComp
Text GLabel 9625 775  2    50   Input ~ 0
GPIO0
Text GLabel 9675 2275 2    50   Input ~ 0
RESET
Wire Wire Line
	9575 2075 9575 2275
Wire Wire Line
	9675 2275 9575 2275
Connection ~ 9575 2275
Wire Wire Line
	9575 775  9575 975 
Wire Wire Line
	9575 775  9625 775 
Connection ~ 9575 775 
Text GLabel 6225 1525 0    50   Input ~ 0
VDD5V
Text GLabel 2650 1575 0    50   Input ~ 0
GPIO0
Text GLabel 3675 3650 2    50   Input ~ 0
PWRGOOD
Text GLabel 4050 1875 2    50   Input ~ 0
PWRGOOD
Wire Wire Line
	4050 3450 3950 3450
Connection ~ 3925 3450
$Comp
L LED:SK6812 D1
U 1 1 5C1E509E
P 5650 2450
F 0 "D1" H 5991 2496 50  0000 L CNN
F 1 "SK6812" H 5991 2405 50  0000 L CNN
F 2 "custom_lib:LED_WS2812B-PLCC4_3.5x3.5" H 5700 2150 50  0001 L TNN
F 3 "https://cdn-shop.adafruit.com/product-files/1138/SK6812+LED+datasheet+.pdf" H 5750 2075 50  0001 L TNN
	1    5650 2450
	1    0    0    -1  
$EndComp
Text GLabel 5650 2750 3    50   Input ~ 0
GND
Text GLabel 5650 2150 1    50   Input ~ 0
VDD5V
NoConn ~ 5950 2450
Text GLabel 4050 1575 2    50   Input ~ 0
PWM
Text GLabel 5350 2450 0    50   Input ~ 0
NEOPX
$Comp
L Device:R_POT RV1
U 1 1 5C1F5A93
P 4450 1375
F 0 "RV1" H 4380 1421 50  0000 R CNN
F 1 "R_POT" H 4380 1330 50  0000 R CNN
F 2 "Potentiometer_THT:Potentiometer_Bourns_PTA2043_Single_Slide" H 4450 1375 50  0001 C CNN
F 3 "~" H 4450 1375 50  0001 C CNN
	1    4450 1375
	-1   0    0    1   
$EndComp
Text GLabel 4450 1525 3    50   Input ~ 0
3.3V
Text GLabel 4450 1225 1    50   Input ~ 0
GND
$Comp
L custom:Generic_TSSOP-14 U4
U 1 1 5C19BBDB
P 8925 3875
F 0 "U4" H 8925 4737 60  0000 C CNN
F 1 "Generic_TSSOP-14" H 8925 4631 60  0000 C CNN
F 2 "Housings_SSOP:TSSOP-14_4.4x5mm_Pitch0.65mm" H 8925 3875 60  0001 C CNN
F 3 "" H 8925 3875 60  0001 C CNN
	1    8925 3875
	1    0    0    -1  
$EndComp
Text GLabel 7775 4675 3    50   Input ~ 0
GND
Wire Wire Line
	8225 4475 7775 4475
Wire Wire Line
	8225 3275 7775 3275
Wire Wire Line
	7775 3275 7775 3675
Connection ~ 7775 4475
Wire Wire Line
	7775 4475 7775 4675
Wire Wire Line
	8225 3675 7775 3675
Connection ~ 7775 3675
Wire Wire Line
	7775 3675 7775 4475
Wire Wire Line
	9625 3275 9625 2925
Wire Wire Line
	9625 2925 7775 2925
Wire Wire Line
	7775 2925 7775 3275
Connection ~ 7775 3275
NoConn ~ 8225 4275
NoConn ~ 8225 3875
Text GLabel 7425 4075 0    50   Input ~ 0
VDD5V
Wire Wire Line
	8225 4075 7575 4075
$Comp
L Device:C C8
U 1 1 5C1B1BC5
P 7575 4225
F 0 "C8" H 7690 4271 50  0000 L CNN
F 1 "0.1u" H 7690 4180 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 7613 4075 50  0001 C CNN
F 3 "~" H 7575 4225 50  0001 C CNN
	1    7575 4225
	1    0    0    -1  
$EndComp
Connection ~ 7575 4075
Wire Wire Line
	7575 4075 7425 4075
$Comp
L Device:C C7
U 1 1 5C1B1C7F
P 7575 3625
F 0 "C7" H 7690 3671 50  0000 L CNN
F 1 "0.1u" H 7690 3580 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 7613 3475 50  0001 C CNN
F 3 "~" H 7575 3625 50  0001 C CNN
	1    7575 3625
	1    0    0    -1  
$EndComp
Wire Wire Line
	8225 3475 8125 3475
Wire Wire Line
	7575 4375 7575 4475
Wire Wire Line
	7575 4475 7775 4475
Wire Wire Line
	9625 4475 9975 4475
Wire Wire Line
	9975 4475 9975 2775
Wire Wire Line
	9975 2775 8125 2775
Wire Wire Line
	8125 2775 8125 3475
Connection ~ 8125 3475
Wire Wire Line
	8125 3475 7575 3475
Text GLabel 7575 3775 0    50   Input ~ 0
GND
Text GLabel 10150 4075 2    50   Input ~ 0
SDA
Text GLabel 10150 3875 2    50   Input ~ 0
SCL
NoConn ~ 9625 4275
$Comp
L Connector_Generic:Conn_01x03 J2
U 1 1 5C1CBE50
P 7050 2350
F 0 "J2" H 7130 2392 50  0000 L CNN
F 1 "Conn_01x03" H 7130 2301 50  0000 L CNN
F 2 "Pin_Headers:Pin_Header_Angled_1x03_Pitch2.54mm" H 7050 2350 50  0001 C CNN
F 3 "~" H 7050 2350 50  0001 C CNN
	1    7050 2350
	1    0    0    -1  
$EndComp
Text GLabel 6850 2250 0    50   Input ~ 0
GND
Text GLabel 6850 2350 0    50   Input ~ 0
VDD5V
Text GLabel 6850 2450 0    50   Input ~ 0
PWM
Wire Wire Line
	3950 3450 3950 3550
Wire Wire Line
	3950 3550 3675 3550
Connection ~ 3950 3450
Wire Wire Line
	3950 3450 3925 3450
$Comp
L roboy_sno-rescue:R-Device R?
U 1 1 5C1E0207
P 2125 1100
AR Path="/5ABCD2F9/5C1E0207" Ref="R?"  Part="1" 
AR Path="/5C1E0207" Ref="R10"  Part="1" 
F 0 "R10" H 2055 1054 50  0000 R CNN
F 1 "10k" H 2055 1145 50  0000 R CNN
F 2 "Resistors_SMD:R_0402" V 2055 1100 50  0001 C CNN
F 3 "~" H 2125 1100 50  0001 C CNN
	1    2125 1100
	-1   0    0    1   
$EndComp
Text GLabel 2125 950  1    50   Input ~ 0
3.3V
Wire Wire Line
	2650 1275 2125 1275
Wire Wire Line
	2125 1275 2125 1250
Text GLabel 9825 3425 1    50   Input ~ 0
GND
Wire Wire Line
	9625 3475 9825 3475
Wire Wire Line
	9825 3475 9825 3425
Wire Wire Line
	9825 3475 9825 3675
Wire Wire Line
	9825 3675 9625 3675
Connection ~ 9825 3475
Wire Wire Line
	9625 3875 10075 3875
Wire Wire Line
	10150 4075 10075 4075
Text GLabel 10450 4375 2    50   Input ~ 0
3.3V
$Comp
L Device:R R11
U 1 1 5C27CC6B
P 10075 3725
F 0 "R11" H 10145 3771 50  0000 L CNN
F 1 "1K" H 10145 3680 50  0000 L CNN
F 2 "Resistors_SMD:R_0402" V 10005 3725 50  0001 C CNN
F 3 "~" H 10075 3725 50  0001 C CNN
	1    10075 3725
	1    0    0    -1  
$EndComp
Connection ~ 10075 3875
Wire Wire Line
	10075 3875 10150 3875
$Comp
L Device:R R12
U 1 1 5C27D1A8
P 10075 4225
F 0 "R12" H 10145 4271 50  0000 L CNN
F 1 "1K" H 10145 4180 50  0000 L CNN
F 2 "Resistors_SMD:R_0402" V 10005 4225 50  0001 C CNN
F 3 "~" H 10075 4225 50  0001 C CNN
	1    10075 4225
	1    0    0    -1  
$EndComp
Connection ~ 10075 4075
Wire Wire Line
	10075 4075 9625 4075
Wire Wire Line
	10075 4375 10425 4375
Wire Wire Line
	10075 3575 10425 3575
Wire Wire Line
	10425 3575 10425 4375
Connection ~ 10425 4375
Wire Wire Line
	10425 4375 10450 4375
Text GLabel 4050 1675 2    50   Input ~ 0
NEOPX
Text GLabel 2650 1675 0    50   Input ~ 0
SDA
Text GLabel 4050 1775 2    50   Input ~ 0
SCL
$Comp
L ESP-WROOM-02U:ESP-WROOM-02U U2
U 1 1 5C51F8BE
P 3350 1675
F 0 "U2" H 3350 2545 50  0000 C CNN
F 1 "ESP-WROOM-02U" H 3350 2454 50  0000 C CNN
F 2 "ESP-WROOM-02U:MODULE_ESP-WROOM-02U" H 3350 1675 50  0001 L BNN
F 3 "1904-1022-1-ND" H 3350 1675 50  0001 L BNN
F 4 "SMD-18 Espressif Systems" H 3350 1675 50  0001 L BNN "Field4"
F 5 "ESP-WROOM-02U" H 3350 1675 50  0001 L BNN "Field5"
F 6 "https://www.digikey.com/product-detail/en/espressif-systems/ESP-WROOM-02U/1904-1022-1-ND/9381731?utm_source=snapeda&utm_medium=aggregator&utm_campaign=symbol" H 3350 1675 50  0001 L BNN "Field6"
F 7 "Module: WiFi; GPIO, I2C, I2S, PWM, SDIO, SPI, UART; U.FL; 2.7÷3.6VDC" H 3350 1675 50  0001 L BNN "Field7"
F 8 "Espressif Systems" H 3350 1675 50  0001 L BNN "Field8"
	1    3350 1675
	1    0    0    -1  
$EndComp
NoConn ~ 6725 1225
NoConn ~ 6725 1325
Wire Wire Line
	7125 925  7025 925 
NoConn ~ 6725 1125
Text GLabel 2650 1375 0    50   Input ~ 0
RESET
Wire Wire Line
	4050 1375 4300 1375
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
Text GLabel 2650 2075 0    50   Input ~ 0
TXD
Text GLabel 2650 2175 0    50   Input ~ 0
RXD
Text GLabel 5400 1250 0    50   Input ~ 0
TXD
Text GLabel 5400 1350 0    50   Input ~ 0
RXD
Text GLabel 2650 1775 0    50   Input ~ 0
ID0
Text GLabel 2650 1875 0    50   Input ~ 0
ID1
Text GLabel 4050 1975 2    50   Input ~ 0
ID2
Text GLabel 1400 2100 3    50   Input ~ 0
ID1
Text GLabel 1400 2700 3    50   Input ~ 0
ID2
Text GLabel 1600 1950 2    50   Input ~ 0
GND
$Comp
L Jumper:SolderJumper_3_Open JP2
U 1 1 5C536D59
P 1400 1950
F 0 "JP2" H 1400 2155 50  0000 C CNN
F 1 "SolderJumper_3_Open" H 1400 2064 50  0000 C CNN
F 2 "custom_lib:Solder_Bridge_3_0402" H 1400 1950 50  0001 C CNN
F 3 "~" H 1400 1950 50  0001 C CNN
	1    1400 1950
	1    0    0    -1  
$EndComp
Text GLabel 1200 1950 0    50   Input ~ 0
3.3V
Text GLabel 1400 1500 3    50   Input ~ 0
ID0
Text GLabel 1600 1350 2    50   Input ~ 0
GND
$Comp
L Jumper:SolderJumper_3_Open JP1
U 1 1 5C53BAE7
P 1400 1350
F 0 "JP1" H 1400 1555 50  0000 C CNN
F 1 "SolderJumper_3_Open" H 1400 1464 50  0000 C CNN
F 2 "custom_lib:Solder_Bridge_3_0402" H 1400 1350 50  0001 C CNN
F 3 "~" H 1400 1350 50  0001 C CNN
	1    1400 1350
	1    0    0    -1  
$EndComp
Text GLabel 1200 1350 0    50   Input ~ 0
3.3V
Text GLabel 1600 2550 2    50   Input ~ 0
GND
$Comp
L Jumper:SolderJumper_3_Open JP3
U 1 1 5C53CDEC
P 1400 2550
F 0 "JP3" H 1400 2755 50  0000 C CNN
F 1 "SolderJumper_3_Open" H 1400 2664 50  0000 C CNN
F 2 "custom_lib:Solder_Bridge_3_0402" H 1400 2550 50  0001 C CNN
F 3 "~" H 1400 2550 50  0001 C CNN
	1    1400 2550
	1    0    0    -1  
$EndComp
Text GLabel 1200 2550 0    50   Input ~ 0
3.3V
$EndSCHEMATC

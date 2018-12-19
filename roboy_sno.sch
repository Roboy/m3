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
Text GLabel 3000 4050 2    50   Input ~ 0
VDD5V
Text GLabel 3075 3650 2    50   Input ~ 0
GND
$Comp
L roboy_sno-rescue:C-Device C3
U 1 1 5ABD740F
P 2875 3900
F 0 "C3" H 2990 3946 50  0000 L CNN
F 1 "10uF" H 2990 3855 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 2913 3750 50  0001 C CNN
F 3 "~" H 2875 3900 50  0001 C CNN
	1    2875 3900
	1    0    0    -1  
$EndComp
$Comp
L roboy_sno-rescue:C-Device C2
U 1 1 5ABD7467
P 1475 3900
F 0 "C2" H 1590 3946 50  0000 L CNN
F 1 "10uF" H 1590 3855 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 1513 3750 50  0001 C CNN
F 3 "~" H 1475 3900 50  0001 C CNN
	1    1475 3900
	1    0    0    -1  
$EndComp
$Comp
L roboy_sno-rescue:LD39200-roboy_sno U1
U 1 1 5AB658D6
P 2225 4150
F 0 "U1" H 2175 4475 50  0000 C CNN
F 1 "LD39200" H 2175 4384 50  0000 C CNN
F 2 "Housings_DFN_QFN:DFN-6-1EP_3x3mm_Pitch0.95mm" H 2225 4150 50  0001 C CNN
F 3 "" H 2225 4150 50  0001 C CNN
	1    2225 4150
	1    0    0    -1  
$EndComp
Wire Wire Line
	1475 4050 1725 4050
Wire Wire Line
	2625 4050 2875 4050
Wire Wire Line
	3075 3650 2875 3650
Wire Wire Line
	1475 3650 1475 3750
Wire Wire Line
	2875 3750 2875 3650
Connection ~ 2875 3650
Wire Wire Line
	2875 3650 1475 3650
Text GLabel 1225 4050 0    50   Input ~ 0
3.3V
Wire Wire Line
	1725 4150 1475 4150
Wire Wire Line
	1475 4150 1475 4050
Connection ~ 1475 4050
Text GLabel 1625 4250 0    50   Input ~ 0
GND
Wire Wire Line
	1625 4250 1725 4250
Text GLabel 4650 1925 2    50   Input ~ 0
SPI_CSO
Wire Wire Line
	1475 4050 1225 4050
$Comp
L roboy_sno-rescue:Conn_01x02_Male-Connector J5
U 1 1 5B881020
P 3325 4525
F 0 "J5" H 3298 4405 50  0000 R CNN
F 1 "Conn_01x02_Male" H 3298 4496 50  0000 R CNN
F 2 "Pin_Headers:Pin_Header_Angled_1x02_Pitch2.54mm" H 3325 4525 50  0001 C CNN
F 3 "~" H 3325 4525 50  0001 C CNN
	1    3325 4525
	-1   0    0    1   
$EndComp
Text GLabel 3125 4425 0    50   Input ~ 0
VDD5V
Text GLabel 3125 4525 0    50   Input ~ 0
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
Text GLabel 2000 1825 0    50   Input ~ 0
GND
NoConn ~ 8550 2725
Wire Wire Line
	8450 2725 7850 2725
Wire Wire Line
	7650 3325 7550 3325
Wire Wire Line
	7950 3325 8150 3325
Wire Wire Line
	8150 2925 7550 2925
Wire Wire Line
	7550 3125 8150 3125
Wire Wire Line
	7450 3025 8150 3025
$Comp
L roboy_sno-rescue:D_Schottky-Device D?
U 1 1 5C1B4309
P 7800 3325
AR Path="/5ABCD2F9/5C1B4309" Ref="D?"  Part="1" 
AR Path="/5C1B4309" Ref="D2"  Part="1" 
F 0 "D2" H 7800 3541 50  0000 C CNN
F 1 "D_Schottky" H 7800 3450 50  0000 C CNN
F 2 "Diodes_SMD:D_SOD-123F" H 7800 3325 50  0001 C CNN
F 3 "~" H 7800 3325 50  0001 C CNN
	1    7800 3325
	1    0    0    -1  
$EndComp
Wire Wire Line
	5550 2925 5700 2925
NoConn ~ 5700 2725
NoConn ~ 5700 2825
NoConn ~ 5700 3025
Wire Wire Line
	5500 3125 5700 3125
Text GLabel 5500 3125 0    50   Input ~ 0
RTS
Text GLabel 5550 2925 0    50   Input ~ 0
DTR
Wire Wire Line
	6850 3575 6800 3575
Connection ~ 6850 3575
Wire Wire Line
	6850 3875 6850 3575
Wire Wire Line
	6900 3875 6850 3875
Wire Wire Line
	7300 3675 7100 3675
Wire Wire Line
	7300 3875 7200 3875
Wire Wire Line
	7300 3675 7300 3875
$Comp
L roboy_sno-rescue:C-Device C?
U 1 1 5C1B431E
P 7050 3875
AR Path="/5ABCD2F9/5C1B431E" Ref="C?"  Part="1" 
AR Path="/5C1B431E" Ref="C4"  Part="1" 
F 0 "C4" V 6798 3875 50  0000 C CNN
F 1 "10n" V 6889 3875 50  0000 C CNN
F 2 "Capacitors_SMD:C_0402" H 7088 3725 50  0001 C CNN
F 3 "~" H 7050 3875 50  0001 C CNN
	1    7050 3875
	0    1    1    0   
$EndComp
Wire Wire Line
	7000 2475 7000 2375
Wire Wire Line
	7000 2375 7250 2375
Connection ~ 7250 2375
Wire Wire Line
	7250 2475 7250 2375
Wire Wire Line
	7050 3125 7050 2775
Wire Wire Line
	7000 3025 7100 3025
Wire Wire Line
	7400 3075 7550 3075
Wire Wire Line
	7400 3025 7400 3075
Wire Wire Line
	7250 2775 7050 2775
Wire Wire Line
	7000 2775 7000 3025
$Comp
L roboy_sno-rescue:C-Device C?
U 1 1 5C1B432F
P 7000 2625
AR Path="/5ABCD2F9/5C1B432F" Ref="C?"  Part="1" 
AR Path="/5C1B432F" Ref="C1"  Part="1" 
F 0 "C1" H 6850 2725 50  0000 L CNN
F 1 "47pF" H 6800 2525 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 7038 2475 50  0001 C CNN
F 3 "~" H 7000 2625 50  0001 C CNN
	1    7000 2625
	1    0    0    -1  
$EndComp
$Comp
L roboy_sno-rescue:C-Device C?
U 1 1 5C1B4336
P 7250 2625
AR Path="/5ABCD2F9/5C1B4336" Ref="C?"  Part="1" 
AR Path="/5C1B4336" Ref="C6"  Part="1" 
F 0 "C6" H 7300 2725 50  0000 L CNN
F 1 "47pF" H 7300 2525 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 7288 2475 50  0001 C CNN
F 3 "~" H 7250 2625 50  0001 C CNN
	1    7250 2625
	1    0    0    -1  
$EndComp
Wire Wire Line
	6500 3575 6250 3575
$Comp
L roboy_sno-rescue:Ferrite_Bead-Device L?
U 1 1 5C1B433E
P 6650 3575
AR Path="/5ABCD2F9/5C1B433E" Ref="L?"  Part="1" 
AR Path="/5C1B433E" Ref="L1"  Part="1" 
F 0 "L1" V 6376 3575 50  0000 C CNN
F 1 "Ferrite_Bead" V 6600 3575 50  0000 C CNN
F 2 "Capacitors_SMD:C_0402" V 6580 3575 50  0001 C CNN
F 3 "~" H 6650 3575 50  0001 C CNN
	1    6650 3575
	0    1    1    0   
$EndComp
NoConn ~ 5700 2625
NoConn ~ 5700 2475
NoConn ~ 5700 2175
Text GLabel 7450 3675 2    50   Input ~ 0
GND
Text GLabel 8150 2375 2    50   Input ~ 0
GND
Text GLabel 6900 2025 3    50   Input ~ 0
GND
Wire Wire Line
	6450 1875 6900 1875
Wire Wire Line
	6450 2025 6450 1875
Connection ~ 6450 1875
Wire Wire Line
	6350 1875 6450 1875
Wire Wire Line
	6350 1875 6350 2025
Wire Wire Line
	6900 1875 6900 2025
Connection ~ 6350 1875
Wire Wire Line
	6250 1875 6350 1875
Wire Wire Line
	6250 2025 6250 1875
Wire Wire Line
	6100 3775 6100 3475
Wire Wire Line
	6950 3775 6100 3775
Wire Wire Line
	6950 3325 6950 3775
Wire Wire Line
	6950 3325 6850 3325
Connection ~ 6950 3325
Wire Wire Line
	6950 2875 6950 3325
Wire Wire Line
	6850 2875 6950 2875
Wire Wire Line
	7850 2625 7850 2725
Wire Wire Line
	7550 2625 7850 2625
Wire Wire Line
	7550 2925 7550 2625
Wire Wire Line
	7550 3575 6850 3575
Wire Wire Line
	7550 3325 7550 3575
Connection ~ 7000 3025
Wire Wire Line
	6850 3025 7000 3025
Wire Wire Line
	7050 3125 6850 3125
Wire Wire Line
	7550 3075 7550 3125
Wire Wire Line
	7450 3125 7450 3025
Wire Wire Line
	7350 3125 7450 3125
$Comp
L roboy_sno-rescue:R-Device R?
U 1 1 5C1B4366
P 7250 3025
AR Path="/5ABCD2F9/5C1B4366" Ref="R?"  Part="1" 
AR Path="/5C1B4366" Ref="R5"  Part="1" 
F 0 "R5" V 7150 3025 50  0000 C CNN
F 1 "27" V 7250 3025 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 7180 3025 50  0001 C CNN
F 3 "~" H 7250 3025 50  0001 C CNN
	1    7250 3025
	0    1    1    0   
$EndComp
Connection ~ 7050 3125
$Comp
L roboy_sno-rescue:R-Device R?
U 1 1 5C1B436E
P 7200 3125
AR Path="/5ABCD2F9/5C1B436E" Ref="R?"  Part="1" 
AR Path="/5C1B436E" Ref="R4"  Part="1" 
F 0 "R4" V 7300 3125 50  0000 C CNN
F 1 "27" V 7200 3125 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 7130 3125 50  0001 C CNN
F 3 "~" H 7200 3125 50  0001 C CNN
	1    7200 3125
	0    1    1    0   
$EndComp
Connection ~ 7850 2625
Wire Wire Line
	7250 2375 7850 2375
Wire Wire Line
	7850 2375 8150 2375
Connection ~ 7850 2375
Wire Wire Line
	7850 2375 7850 2625
Wire Wire Line
	7100 3325 6950 3325
Wire Wire Line
	7100 3675 7100 3625
Connection ~ 7300 3675
Wire Wire Line
	7450 3675 7300 3675
$Comp
L roboy_sno-rescue:C-Device C?
U 1 1 5C1B437E
P 7100 3475
AR Path="/5ABCD2F9/5C1B437E" Ref="C?"  Part="1" 
AR Path="/5C1B437E" Ref="C5"  Part="1" 
F 0 "C5" H 7215 3521 50  0000 L CNN
F 1 "100n" H 7215 3430 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 7138 3325 50  0001 C CNN
F 3 "~" H 7100 3475 50  0001 C CNN
	1    7100 3475
	1    0    0    -1  
$EndComp
$Comp
L roboy_sno-rescue:USB_B_Mini-Connector_Specialized J?
U 1 1 5C1B4385
P 8450 3125
AR Path="/5ABCD2F9/5C1B4385" Ref="J?"  Part="1" 
AR Path="/5C1B4385" Ref="J1"  Part="1" 
F 0 "J1" H 8221 3023 50  0000 R CNN
F 1 "USB_B_Mini" H 8221 3114 50  0000 R CNN
F 2 "Connectors_USB:USB_Micro-B_Molex_47346-0001" H 8600 3075 50  0001 C CNN
F 3 "~" H 8600 3075 50  0001 C CNN
	1    8450 3125
	-1   0    0    1   
$EndComp
$Comp
L roboy_sno-rescue:FT231XQ-T-roboy_sno U?
U 1 1 5C1B438C
P 6250 2775
AR Path="/5ABCD2F9/5C1B438C" Ref="U?"  Part="1" 
AR Path="/5C1B438C" Ref="U3"  Part="1" 
F 0 "U3" H 6225 3561 50  0000 C CNN
F 1 "FT231XQ-T" H 6225 3652 50  0000 C CNN
F 2 "Housings_DFN_QFN:QFN-20-1EP_4x4mm_Pitch0.5mm" H 6000 3475 50  0001 C CNN
F 3 "" H 6000 3475 50  0001 C CNN
	1    6250 2775
	-1   0    0    1   
$EndComp
Text GLabel 2050 1725 0    50   Input ~ 0
3.3V
Wire Wire Line
	5100 3325 5700 3325
Wire Wire Line
	4650 1425 5100 1425
Wire Wire Line
	5100 1425 5100 3325
Wire Wire Line
	5700 3225 5200 3225
Wire Wire Line
	5200 3225 5200 1325
Wire Wire Line
	5200 1325 4650 1325
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
Wire Wire Line
	2000 1825 2050 1825
Text GLabel 7650 3325 3    50   Input ~ 0
VDD5V
$Comp
L roboy_sno-rescue:R-Device R?
U 1 1 5C1B43D5
P 5450 1925
AR Path="/5ABCD2F9/5C1B43D5" Ref="R?"  Part="1" 
AR Path="/5C1B43D5" Ref="R3"  Part="1" 
F 0 "R3" H 5380 1879 50  0000 R CNN
F 1 "10k" H 5380 1970 50  0000 R CNN
F 2 "Resistors_SMD:R_0402" V 5380 1925 50  0001 C CNN
F 3 "~" H 5450 1925 50  0001 C CNN
	1    5450 1925
	0    -1   -1   0   
$EndComp
Wire Wire Line
	5300 1925 4650 1925
Wire Wire Line
	6250 1875 5600 1875
Wire Wire Line
	5600 1875 5600 1925
Connection ~ 6250 1875
$Comp
L roboy_sno-rescue:R-Device R?
U 1 1 5C1B43E0
P 5450 1675
AR Path="/5ABCD2F9/5C1B43E0" Ref="R?"  Part="1" 
AR Path="/5C1B43E0" Ref="R2"  Part="1" 
F 0 "R2" H 5380 1629 50  0000 R CNN
F 1 "10k" H 5380 1720 50  0000 R CNN
F 2 "Resistors_SMD:R_0402" V 5380 1675 50  0001 C CNN
F 3 "~" H 5450 1675 50  0001 C CNN
	1    5450 1675
	0    -1   -1   0   
$EndComp
Wire Wire Line
	5300 1675 5300 1825
Wire Wire Line
	5300 1825 4650 1825
Text GLabel 5600 1675 2    50   Input ~ 0
3.3V
Wire Wire Line
	6250 3575 6250 3475
NoConn ~ 2950 2875
NoConn ~ 3100 2875
NoConn ~ 3550 2875
NoConn ~ 3700 2875
Text GLabel 4650 1725 2    50   Input ~ 0
GPIO0
$Comp
L roboy_sno-rescue:ESP8266-ESP-12E-roboy_sno U?
U 1 1 5C1B43F0
P 3350 1925
AR Path="/5ABCD2F9/5C1B43F0" Ref="U?"  Part="1" 
AR Path="/5C1B43F0" Ref="U2"  Part="1" 
F 0 "U2" H 3450 3252 60  0000 C CNN
F 1 "ESP8266-ESP-12E" H 3450 3146 60  0000 C CNN
F 2 "roboy_sno:ESP-12E_SMD" H 2650 1875 60  0001 C CNN
F 3 "" H 2650 1875 60  0000 C CNN
	1    3350 1925
	1    0    0    -1  
$EndComp
NoConn ~ 5700 2275
NoConn ~ 5700 2375
Wire Wire Line
	4650 1525 4775 1525
Wire Wire Line
	4650 1625 4775 1625
Text GLabel 4650 2125 2    50   Input ~ 0
SPI_MISO
Text GLabel 4650 2025 2    50   Input ~ 0
SPI_MOSI
Text GLabel 4650 2225 2    50   Input ~ 0
SPI_CLK
Text GLabel 2625 4250 2    50   Input ~ 0
PWRGOOD
Text GLabel 4650 2325 2    50   Input ~ 0
PWRGOOD
Wire Wire Line
	3000 4050 2900 4050
Connection ~ 2875 4050
$Comp
L LED:SK6812 D1
U 1 1 5C1E509E
P 5500 4500
F 0 "D1" H 5841 4546 50  0000 L CNN
F 1 "SK6812" H 5841 4455 50  0000 L CNN
F 2 "custom_lib:LED_WS2812B-PLCC4_3.5x3.5" H 5550 4200 50  0001 L TNN
F 3 "https://cdn-shop.adafruit.com/product-files/1138/SK6812+LED+datasheet+.pdf" H 5600 4125 50  0001 L TNN
	1    5500 4500
	1    0    0    -1  
$EndComp
Text GLabel 5500 4800 3    50   Input ~ 0
GND
Text GLabel 5500 4200 1    50   Input ~ 0
VDD5V
NoConn ~ 5800 4500
Text GLabel 4775 1525 2    50   Input ~ 0
NEOPX
Text GLabel 4775 1625 2    50   Input ~ 0
PWM
Text GLabel 5200 4500 0    50   Input ~ 0
NEOPX
NoConn ~ 3400 2875
NoConn ~ 3250 2875
Wire Wire Line
	2050 1425 1150 1425
Wire Wire Line
	1150 1425 1150 1400
$Comp
L Device:R_POT RV1
U 1 1 5C1F5A93
P 1000 1400
F 0 "RV1" H 930 1446 50  0000 R CNN
F 1 "R_POT" H 930 1355 50  0000 R CNN
F 2 "Potentiometer_THT:Potentiometer_Bourns_PTA2043_Single_Slide" H 1000 1400 50  0001 C CNN
F 3 "~" H 1000 1400 50  0001 C CNN
	1    1000 1400
	1    0    0    -1  
$EndComp
Text GLabel 1000 1250 1    50   Input ~ 0
3.3V
Text GLabel 1000 1550 3    50   Input ~ 0
GND
$Comp
L custom:Generic_TSSOP-14 U4
U 1 1 5C19BBDB
P 8900 5050
F 0 "U4" H 8900 5912 60  0000 C CNN
F 1 "Generic_TSSOP-14" H 8900 5806 60  0000 C CNN
F 2 "Housings_SSOP:TSSOP-14_4.4x5mm_Pitch0.65mm" H 8900 5050 60  0001 C CNN
F 3 "" H 8900 5050 60  0001 C CNN
	1    8900 5050
	1    0    0    -1  
$EndComp
Text GLabel 7750 5850 3    50   Input ~ 0
GND
Wire Wire Line
	8200 5650 7750 5650
Wire Wire Line
	8200 4450 7750 4450
Wire Wire Line
	7750 4450 7750 4850
Connection ~ 7750 5650
Wire Wire Line
	7750 5650 7750 5850
Wire Wire Line
	8200 4850 7750 4850
Connection ~ 7750 4850
Wire Wire Line
	7750 4850 7750 5650
Wire Wire Line
	9600 4450 9600 4100
Wire Wire Line
	9600 4100 7750 4100
Wire Wire Line
	7750 4100 7750 4450
Connection ~ 7750 4450
NoConn ~ 8200 5450
NoConn ~ 8200 5050
Text GLabel 7400 5250 0    50   Input ~ 0
VDD5V
Wire Wire Line
	8200 5250 7550 5250
$Comp
L Device:C C8
U 1 1 5C1B1BC5
P 7550 5400
F 0 "C8" H 7665 5446 50  0000 L CNN
F 1 "C" H 7665 5355 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 7588 5250 50  0001 C CNN
F 3 "~" H 7550 5400 50  0001 C CNN
	1    7550 5400
	1    0    0    -1  
$EndComp
Connection ~ 7550 5250
Wire Wire Line
	7550 5250 7400 5250
$Comp
L Device:C C7
U 1 1 5C1B1C7F
P 7550 4800
F 0 "C7" H 7665 4846 50  0000 L CNN
F 1 "C" H 7665 4755 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 7588 4650 50  0001 C CNN
F 3 "~" H 7550 4800 50  0001 C CNN
	1    7550 4800
	1    0    0    -1  
$EndComp
Wire Wire Line
	8200 4650 8100 4650
Wire Wire Line
	7550 5550 7550 5650
Wire Wire Line
	7550 5650 7750 5650
Wire Wire Line
	9600 5650 9950 5650
Wire Wire Line
	9950 5650 9950 3950
Wire Wire Line
	9950 3950 8100 3950
Wire Wire Line
	8100 3950 8100 4650
Connection ~ 8100 4650
Wire Wire Line
	8100 4650 7550 4650
Text GLabel 7550 4950 0    50   Input ~ 0
GND
Text GLabel 9600 4650 2    50   Input ~ 0
SPI_CSO
Text GLabel 9600 5250 2    50   Input ~ 0
SPI_MISO
Text GLabel 9600 4850 2    50   Input ~ 0
SPI_MOSI
Text GLabel 9600 5050 2    50   Input ~ 0
SPI_CLK
NoConn ~ 9600 5450
$Comp
L Connector_Generic:Conn_01x03 J2
U 1 1 5C1CBE50
P 4300 5450
F 0 "J2" H 4380 5492 50  0000 L CNN
F 1 "Conn_01x03" H 4380 5401 50  0000 L CNN
F 2 "Pin_Headers:Pin_Header_Angled_1x03_Pitch2.54mm" H 4300 5450 50  0001 C CNN
F 3 "~" H 4300 5450 50  0001 C CNN
	1    4300 5450
	1    0    0    -1  
$EndComp
Text GLabel 4100 5350 0    50   Input ~ 0
GND
Text GLabel 4100 5450 0    50   Input ~ 0
VDD5V
Text GLabel 4100 5550 0    50   Input ~ 0
PWM
Wire Wire Line
	2900 4050 2900 4150
Wire Wire Line
	2900 4150 2625 4150
Connection ~ 2900 4050
Wire Wire Line
	2900 4050 2875 4050
$Comp
L roboy_sno-rescue:R-Device R?
U 1 1 5C1E0207
P 1525 1150
AR Path="/5ABCD2F9/5C1E0207" Ref="R?"  Part="1" 
AR Path="/5C1E0207" Ref="R10"  Part="1" 
F 0 "R10" H 1455 1104 50  0000 R CNN
F 1 "10k" H 1455 1195 50  0000 R CNN
F 2 "Resistors_SMD:R_0402" V 1455 1150 50  0001 C CNN
F 3 "~" H 1525 1150 50  0001 C CNN
	1    1525 1150
	-1   0    0    1   
$EndComp
Text GLabel 1525 1000 1    50   Input ~ 0
3.3V
Wire Wire Line
	2050 1325 1525 1325
Wire Wire Line
	1525 1325 1525 1300
$Comp
L roboy_sno-rescue:R-Device R?
U 1 1 5C1F3ACB
P 1375 2225
AR Path="/5ABCD2F9/5C1F3ACB" Ref="R?"  Part="1" 
AR Path="/5C1F3ACB" Ref="R1"  Part="1" 
F 0 "R1" H 1305 2179 50  0000 R CNN
F 1 "10k" H 1305 2270 50  0000 R CNN
F 2 "Resistors_SMD:R_0402" V 1305 2225 50  0001 C CNN
F 3 "~" H 1375 2225 50  0001 C CNN
	1    1375 2225
	1    0    0    -1  
$EndComp
Text GLabel 1375 2375 3    50   Input ~ 0
3.3V
Wire Wire Line
	2050 1525 1375 1525
Wire Wire Line
	1375 1525 1375 2075
$EndSCHEMATC

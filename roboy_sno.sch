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
Wire Wire Line
	8975 1700 8875 1700
Connection ~ 8850 1700
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
P 2150 2475
AR Path="/5ABCD2F9/5C1E0207" Ref="R?"  Part="1" 
AR Path="/5C1E0207" Ref="R10"  Part="1" 
F 0 "R10" H 2080 2429 50  0000 R CNN
F 1 "10k" H 2080 2520 50  0000 R CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 2080 2475 50  0001 C CNN
F 3 "~" H 2150 2475 50  0001 C CNN
	1    2150 2475
	-1   0    0    1   
$EndComp
Text GLabel 2350 3425 0    50   Input ~ 0
TXD
Text GLabel 2350 3525 0    50   Input ~ 0
RXD
Text GLabel 5425 1050 0    50   Input ~ 0
TXD
Text GLabel 5425 1150 0    50   Input ~ 0
RXD
$Comp
L Switch:SW_Push SW2
U 1 1 5CD5B563
P 2150 2925
F 0 "SW2" H 2150 2850 50  0000 C CNN
F 1 "BOOT" H 2150 3050 50  0000 C CNN
F 2 "custom_lib:PTS815-SJK" H 2150 3125 50  0001 C CNN
F 3 "" H 2150 3125 50  0001 C CNN
	1    2150 2925
	1    0    0    -1  
$EndComp
Text GLabel 3750 3225 2    50   Input ~ 0
MOTOR
Text GLabel 3750 3325 2    50   Input ~ 0
MOTOR_SENSE
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
	3875 1900 3875 2175
$Comp
L roboy_sno-rescue:C-Device-roboy_sno-rescue C4
U 1 1 5CD5FA82
P 3675 2025
F 0 "C4" H 3790 2071 50  0000 L CNN
F 1 "0.1uF" H 3790 1980 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 3713 1875 50  0001 C CNN
F 3 "~" H 3675 2025 50  0001 C CNN
	1    3675 2025
	-1   0    0    1   
$EndComp
$Comp
L roboy_sno-rescue:C-Device-roboy_sno-rescue C5
U 1 1 5CD5FE9C
P 4075 2025
F 0 "C5" H 4190 2071 50  0000 L CNN
F 1 "10uF" H 4190 1980 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 4113 1875 50  0001 C CNN
F 3 "~" H 4075 2025 50  0001 C CNN
	1    4075 2025
	1    0    0    -1  
$EndComp
Wire Wire Line
	3675 2175 3875 2175
Connection ~ 3875 2175
Wire Wire Line
	3875 2175 4075 2175
$Comp
L Connector:Conn_01x04_Female J3
U 1 1 5CD5CBBC
P 5625 950
F 0 "J3" H 5653 926 50  0000 L CNN
F 1 "UART" H 5653 835 50  0000 L CNN
F 2 "custom_lib:TE-Connectivity_Micro-Match_connector_02x02_Pitch_1.27mm" H 5625 950 50  0001 C CNN
F 3 "~" H 5625 950 50  0001 C CNN
	1    5625 950 
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0102
U 1 1 5DD8599E
P 5425 950
F 0 "#PWR0102" H 5425 800 50  0001 C CNN
F 1 "+5V" V 5440 1078 50  0000 L CNN
F 2 "" H 5425 950 50  0001 C CNN
F 3 "" H 5425 950 50  0001 C CNN
	1    5425 950 
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
L power:GND #PWR0106
U 1 1 5DDC3139
P 3750 3725
F 0 "#PWR0106" H 3750 3475 50  0001 C CNN
F 1 "GND" H 3755 3552 50  0000 C CNN
F 2 "" H 3750 3725 50  0001 C CNN
F 3 "" H 3750 3725 50  0001 C CNN
	1    3750 3725
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
P 5425 850
F 0 "#PWR0112" H 5425 600 50  0001 C CNN
F 1 "GND" V 5430 722 50  0000 R CNN
F 2 "" H 5425 850 50  0001 C CNN
F 3 "" H 5425 850 50  0001 C CNN
	1    5425 850 
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0115
U 1 1 5DDC7690
P 3675 1875
F 0 "#PWR0115" H 3675 1625 50  0001 C CNN
F 1 "GND" H 3680 1702 50  0000 C CNN
F 2 "" H 3675 1875 50  0001 C CNN
F 3 "" H 3675 1875 50  0001 C CNN
	1    3675 1875
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR0116
U 1 1 5DDC7B04
P 4075 1875
F 0 "#PWR0116" H 4075 1625 50  0001 C CNN
F 1 "GND" H 4080 1702 50  0000 C CNN
F 2 "" H 4075 1875 50  0001 C CNN
F 3 "" H 4075 1875 50  0001 C CNN
	1    4075 1875
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR0117
U 1 1 5DDC7EE2
P 1950 2925
F 0 "#PWR0117" H 1950 2675 50  0001 C CNN
F 1 "GND" H 1955 2752 50  0000 C CNN
F 2 "" H 1950 2925 50  0001 C CNN
F 3 "" H 1950 2925 50  0001 C CNN
	1    1950 2925
	0    1    1    0   
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
P 3875 1900
F 0 "#PWR0120" H 3875 1750 50  0001 C CNN
F 1 "+3.3V" V 3875 2125 50  0000 C CNN
F 2 "" H 3875 1900 50  0001 C CNN
F 3 "" H 3875 1900 50  0001 C CNN
	1    3875 1900
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR0121
U 1 1 5DDCBD60
P 2150 2325
F 0 "#PWR0121" H 2150 2175 50  0001 C CNN
F 1 "+3.3V" H 2165 2498 50  0000 C CNN
F 2 "" H 2150 2325 50  0001 C CNN
F 3 "" H 2150 2325 50  0001 C CNN
	1    2150 2325
	1    0    0    -1  
$EndComp
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
Text GLabel 3750 3025 2    50   Input ~ 0
ID0
Text GLabel 2350 3125 0    50   Input ~ 0
ID1
Text GLabel 2350 3225 0    50   Input ~ 0
ID2
Text GLabel 3750 2925 2    50   Input ~ 0
ID3
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
Text GLabel 3750 3125 2    50   Input ~ 0
E0
Text GLabel 2350 3025 0    50   Input ~ 0
E1
NoConn ~ 8600 1900
$Comp
L Mechanical:MountingHole_Pad H1
U 1 1 5DDBEBB0
P 8625 2400
F 0 "H1" H 8725 2446 50  0000 L CNN
F 1 "MountingHole" H 8725 2355 50  0000 L CNN
F 2 "MountingHole:MountingHole_2.2mm_M2_Pad" H 8625 2400 50  0001 C CNN
F 3 "~" H 8625 2400 50  0001 C CNN
	1    8625 2400
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole_Pad H2
U 1 1 5DDC1C0E
P 8650 3000
F 0 "H2" H 8750 3046 50  0000 L CNN
F 1 "MountingHole" H 8750 2955 50  0000 L CNN
F 2 "MountingHole:MountingHole_2.2mm_M2_Pad" H 8650 3000 50  0001 C CNN
F 3 "~" H 8650 3000 50  0001 C CNN
	1    8650 3000
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
Wire Wire Line
	3875 2425 3750 2425
Wire Wire Line
	3875 2175 3875 2425
Wire Wire Line
	2350 2625 2150 2625
$Comp
L roboy_sno-rescue:C-Device-roboy_sno-rescue C1
U 1 1 5DE6C267
P 1825 2625
F 0 "C1" H 1940 2671 50  0000 L CNN
F 1 "0.1uF" H 1940 2580 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 1863 2475 50  0001 C CNN
F 3 "~" H 1825 2625 50  0001 C CNN
	1    1825 2625
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR0101
U 1 1 5DE6C36D
P 1675 2625
F 0 "#PWR0101" H 1675 2375 50  0001 C CNN
F 1 "GND" H 1680 2452 50  0000 C CNN
F 2 "" H 1675 2625 50  0001 C CNN
F 3 "" H 1675 2625 50  0001 C CNN
	1    1675 2625
	0    1    1    0   
$EndComp
Wire Wire Line
	1975 2625 2150 2625
Connection ~ 2150 2625
$Comp
L power:+3.3V #PWR0107
U 1 1 5DE6FC9C
P 7425 2975
F 0 "#PWR0107" H 7425 2825 50  0001 C CNN
F 1 "+3.3V" V 7425 3200 50  0000 C CNN
F 2 "" H 7425 2975 50  0001 C CNN
F 3 "" H 7425 2975 50  0001 C CNN
	1    7425 2975
	0    -1   -1   0   
$EndComp
NoConn ~ 2350 2725
$Comp
L ESP-WROOM-02U:ESP-WROOM-02U U2
U 1 1 5DE72B48
P 3050 3025
F 0 "U2" H 3050 3895 50  0000 C CNN
F 1 "ESP-WROOM-02U" H 3050 3804 50  0000 C CNN
F 2 "ESP-WROOM-02U:MODULE_ESP-WROOM-02U" H 3050 3025 50  0001 L BNN
F 3 "1904-1022-1-ND" H 3050 3025 50  0001 L BNN
F 4 "SMD-18 Espressif Systems" H 3050 3025 50  0001 L BNN "Field4"
F 5 "ESP-WROOM-02U" H 3050 3025 50  0001 L BNN "Field5"
F 6 "https://www.digikey.com/product-detail/en/espressif-systems/ESP-WROOM-02U/1904-1022-1-ND/9381731?utm_source=snapeda&utm_medium=aggregator&utm_campaign=symbol" H 3050 3025 50  0001 L BNN "Field6"
F 7 "Module: WiFi; GPIO, I2C, I2S, PWM, SDIO, SPI, UART; U.FL; 2.7÷3.6VDC" H 3050 3025 50  0001 L BNN "Field7"
F 8 "Espressif Systems" H 3050 3025 50  0001 L BNN "Field8"
	1    3050 3025
	1    0    0    -1  
$EndComp
NoConn ~ 3750 2725
NoConn ~ 3750 3525
$Comp
L power:+3.3V #PWR0113
U 1 1 5DE7C018
P 6775 3550
F 0 "#PWR0113" H 6775 3400 50  0001 C CNN
F 1 "+3.3V" V 6775 3775 50  0000 C CNN
F 2 "" H 6775 3550 50  0001 C CNN
F 3 "" H 6775 3550 50  0001 C CNN
	1    6775 3550
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5DE7D09E
P 8650 3100
F 0 "#PWR?" H 8650 2850 50  0001 C CNN
F 1 "GND" H 8655 2927 50  0000 C CNN
F 2 "" H 8650 3100 50  0001 C CNN
F 3 "" H 8650 3100 50  0001 C CNN
	1    8650 3100
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5DE7D0D3
P 8625 2500
F 0 "#PWR?" H 8625 2250 50  0001 C CNN
F 1 "GND" H 8630 2327 50  0000 C CNN
F 2 "" H 8625 2500 50  0001 C CNN
F 3 "" H 8625 2500 50  0001 C CNN
	1    8625 2500
	1    0    0    -1  
$EndComp
$EndSCHEMATC

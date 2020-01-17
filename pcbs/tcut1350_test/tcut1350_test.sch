EESchema Schematic File Version 4
LIBS:tcut1350_test-cache
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
L Connector:Conn_01x06_Female J1
U 1 1 5E2174D8
P 4350 2075
F 0 "J1" H 4377 2051 50  0000 L CNN
F 1 "Conn_01x06_Female" H 4377 1960 50  0000 L CNN
F 2 "custom_lib:tcut1350x01" H 4350 2075 50  0001 C CNN
F 3 "~" H 4350 2075 50  0001 C CNN
	1    4350 2075
	1    0    0    -1  
$EndComp
$Comp
L Device:R_POT RV3
U 1 1 5E21756D
P 3525 1725
F 0 "RV3" H 3455 1771 50  0000 R CNN
F 1 "R_POT" H 3455 1680 50  0000 R CNN
F 2 "Potentiometer_THT:Potentiometer_Bourns_PTA2043_Single_Slide" H 3525 1725 50  0001 C CNN
F 3 "~" H 3525 1725 50  0001 C CNN
	1    3525 1725
	0    1    1    0   
$EndComp
NoConn ~ 3675 1725
Wire Wire Line
	4150 1875 3750 1875
$Comp
L Device:R_POT RV2
U 1 1 5E21769D
P 3375 2350
F 0 "RV2" H 3305 2396 50  0000 R CNN
F 1 "R_POT" H 3305 2305 50  0000 R CNN
F 2 "Potentiometer_THT:Potentiometer_Bourns_PTA2043_Single_Slide" H 3375 2350 50  0001 C CNN
F 3 "~" H 3375 2350 50  0001 C CNN
	1    3375 2350
	0    1    1    0   
$EndComp
NoConn ~ 3525 2350
$Comp
L power:GND #PWR0101
U 1 1 5E2177A9
P 3375 1725
F 0 "#PWR0101" H 3375 1475 50  0001 C CNN
F 1 "GND" V 3380 1597 50  0000 R CNN
F 2 "" H 3375 1725 50  0001 C CNN
F 3 "" H 3375 1725 50  0001 C CNN
	1    3375 1725
	0    1    1    0   
$EndComp
Wire Wire Line
	4150 1975 3825 1975
$Comp
L power:+3.3V #PWR0103
U 1 1 5E21791A
P 4150 2075
F 0 "#PWR0103" H 4150 1925 50  0001 C CNN
F 1 "+3.3V" V 4165 2203 50  0000 L CNN
F 2 "" H 4150 2075 50  0001 C CNN
F 3 "" H 4150 2075 50  0001 C CNN
	1    4150 2075
	0    -1   -1   0   
$EndComp
Wire Wire Line
	3675 2175 3675 2500
Wire Wire Line
	3675 2500 3375 2500
Wire Wire Line
	3675 2175 3900 2175
NoConn ~ 4150 2275
$Comp
L power:GND #PWR0104
U 1 1 5E217AD2
P 4150 2375
F 0 "#PWR0104" H 4150 2125 50  0001 C CNN
F 1 "GND" V 4155 2247 50  0000 R CNN
F 2 "" H 4150 2375 50  0001 C CNN
F 3 "" H 4150 2375 50  0001 C CNN
	1    4150 2375
	0    1    1    0   
$EndComp
$Comp
L Device:R_POT RV1
U 1 1 5E217B9D
P 2925 1825
F 0 "RV1" H 2855 1871 50  0000 R CNN
F 1 "R_POT" H 2855 1780 50  0000 R CNN
F 2 "Potentiometer_THT:Potentiometer_Bourns_PTA2043_Single_Slide" H 2925 1825 50  0001 C CNN
F 3 "~" H 2925 1825 50  0001 C CNN
	1    2925 1825
	0    1    1    0   
$EndComp
NoConn ~ 3075 1825
$Comp
L power:GND #PWR0105
U 1 1 5E217BA4
P 2775 1825
F 0 "#PWR0105" H 2775 1575 50  0001 C CNN
F 1 "GND" V 2780 1697 50  0000 R CNN
F 2 "" H 2775 1825 50  0001 C CNN
F 3 "" H 2775 1825 50  0001 C CNN
	1    2775 1825
	0    1    1    0   
$EndComp
$Comp
L Connector:Conn_01x05_Female J2
U 1 1 5E217D0C
P 4400 1375
F 0 "J2" H 4427 1401 50  0000 L CNN
F 1 "Conn_01x05_Female" H 4427 1310 50  0000 L CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_1x05_P2.54mm_Vertical" H 4400 1375 50  0001 C CNN
F 3 "~" H 4400 1375 50  0001 C CNN
	1    4400 1375
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR0106
U 1 1 5E217D6A
P 4200 1175
F 0 "#PWR0106" H 4200 1025 50  0001 C CNN
F 1 "+3.3V" V 4215 1303 50  0000 L CNN
F 2 "" H 4200 1175 50  0001 C CNN
F 3 "" H 4200 1175 50  0001 C CNN
	1    4200 1175
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR0107
U 1 1 5E217D7F
P 4200 1275
F 0 "#PWR0107" H 4200 1025 50  0001 C CNN
F 1 "GND" V 4205 1147 50  0000 R CNN
F 2 "" H 4200 1275 50  0001 C CNN
F 3 "" H 4200 1275 50  0001 C CNN
	1    4200 1275
	0    1    1    0   
$EndComp
Connection ~ 3750 1875
Wire Wire Line
	3750 1875 3525 1875
Wire Wire Line
	4200 1475 3825 1475
Wire Wire Line
	3825 1475 3825 1975
Connection ~ 3825 1975
Wire Wire Line
	3825 1975 2925 1975
Connection ~ 3900 2175
Wire Wire Line
	3900 2175 4150 2175
Wire Wire Line
	4200 1375 3900 1375
Wire Wire Line
	3900 1375 3900 2175
Wire Wire Line
	4200 1575 3750 1575
Wire Wire Line
	3750 1575 3750 1875
$Comp
L power:+3.3V #PWR?
U 1 1 5E21C54D
P 3225 2350
F 0 "#PWR?" H 3225 2200 50  0001 C CNN
F 1 "+3.3V" V 3240 2478 50  0000 L CNN
F 2 "" H 3225 2350 50  0001 C CNN
F 3 "" H 3225 2350 50  0001 C CNN
	1    3225 2350
	0    -1   -1   0   
$EndComp
$EndSCHEMATC

-- megafunction wizard: %LPM_MULT%
-- GENERATION: STANDARD
-- VERSION: WM1.0
-- MODULE: lpm_mult 

-- ============================================================
-- File Name: mult_xy.vhd
-- Megafunction Name(s):
-- 			lpm_mult
--
-- Simulation Library Files(s):
-- 			lpm
-- ============================================================
-- ************************************************************
-- THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
--
-- 18.1.0 Build 625 09/12/2018 SJ Lite Edition
-- ************************************************************


--Copyright (C) 2018  Intel Corporation. All rights reserved.
--Your use of Intel Corporation's design tools, logic functions 
--and other software and tools, and its AMPP partner logic 
--functions, and any output files from any of the foregoing 
--(including device programming or simulation files), and any 
--associated documentation or information are expressly subject 
--to the terms and conditions of the Intel Program License 
--Subscription Agreement, the Intel Quartus Prime License Agreement,
--the Intel FPGA IP License Agreement, or other applicable license
--agreement, including, without limitation, that your use is for
--the sole purpose of programming logic devices manufactured by
--Intel and sold by Intel or its authorized distributors.  Please
--refer to the applicable agreement for further details.


LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY lpm;
USE lpm.all;

ENTITY mult_xy IS
	PORT
	(
		dataa		: IN STD_LOGIC_VECTOR (9 DOWNTO 0);
		datab		: IN STD_LOGIC_VECTOR (9 DOWNTO 0);
		result		: OUT STD_LOGIC_VECTOR (18 DOWNTO 0)
	);
END mult_xy;


ARCHITECTURE SYN OF mult_xy IS

	SIGNAL sub_wire0	: STD_LOGIC_VECTOR (18 DOWNTO 0);



	COMPONENT lpm_mult
	GENERIC (
		lpm_hint		: STRING;
		lpm_representation		: STRING;
		lpm_type		: STRING;
		lpm_widtha		: NATURAL;
		lpm_widthb		: NATURAL;
		lpm_widthp		: NATURAL
	);
	PORT (
			dataa	: IN STD_LOGIC_VECTOR (9 DOWNTO 0);
			datab	: IN STD_LOGIC_VECTOR (9 DOWNTO 0);
			result	: OUT STD_LOGIC_VECTOR (18 DOWNTO 0)
	);
	END COMPONENT;

BEGIN
	result    <= sub_wire0(18 DOWNTO 0);

	lpm_mult_component : lpm_mult
	GENERIC MAP (
		lpm_hint => "MAXIMIZE_SPEED=5",
		lpm_representation => "UNSIGNED",
		lpm_type => "LPM_MULT",
		lpm_widtha => 10,
		lpm_widthb => 10,
		lpm_widthp => 19
	)
	PORT MAP (
		dataa => dataa,
		datab => datab,
		result => sub_wire0
	);



END SYN;

-- ============================================================
-- CNX file retrieval info
-- ============================================================
-- Retrieval info: PRIVATE: AutoSizeResult NUMERIC "0"
-- Retrieval info: PRIVATE: B_isConstant NUMERIC "0"
-- Retrieval info: PRIVATE: ConstantB NUMERIC "0"
-- Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "MAX 10"
-- Retrieval info: PRIVATE: LPM_PIPELINE NUMERIC "0"
-- Retrieval info: PRIVATE: Latency NUMERIC "0"
-- Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "0"
-- Retrieval info: PRIVATE: SignedMult NUMERIC "0"
-- Retrieval info: PRIVATE: USE_MULT NUMERIC "1"
-- Retrieval info: PRIVATE: ValidConstant NUMERIC "0"
-- Retrieval info: PRIVATE: WidthA NUMERIC "10"
-- Retrieval info: PRIVATE: WidthB NUMERIC "10"
-- Retrieval info: PRIVATE: WidthP NUMERIC "19"
-- Retrieval info: PRIVATE: aclr NUMERIC "0"
-- Retrieval info: PRIVATE: clken NUMERIC "0"
-- Retrieval info: PRIVATE: new_diagram STRING "1"
-- Retrieval info: PRIVATE: optimize NUMERIC "0"
-- Retrieval info: LIBRARY: lpm lpm.lpm_components.all
-- Retrieval info: CONSTANT: LPM_HINT STRING "MAXIMIZE_SPEED=5"
-- Retrieval info: CONSTANT: LPM_REPRESENTATION STRING "UNSIGNED"
-- Retrieval info: CONSTANT: LPM_TYPE STRING "LPM_MULT"
-- Retrieval info: CONSTANT: LPM_WIDTHA NUMERIC "10"
-- Retrieval info: CONSTANT: LPM_WIDTHB NUMERIC "10"
-- Retrieval info: CONSTANT: LPM_WIDTHP NUMERIC "19"
-- Retrieval info: USED_PORT: dataa 0 0 10 0 INPUT NODEFVAL "dataa[9..0]"
-- Retrieval info: USED_PORT: datab 0 0 10 0 INPUT NODEFVAL "datab[9..0]"
-- Retrieval info: USED_PORT: result 0 0 19 0 OUTPUT NODEFVAL "result[18..0]"
-- Retrieval info: CONNECT: @dataa 0 0 10 0 dataa 0 0 10 0
-- Retrieval info: CONNECT: @datab 0 0 10 0 datab 0 0 10 0
-- Retrieval info: CONNECT: result 0 0 19 0 @result 0 0 19 0
-- Retrieval info: GEN_FILE: TYPE_NORMAL mult_xy.vhd TRUE
-- Retrieval info: GEN_FILE: TYPE_NORMAL mult_xy.inc FALSE
-- Retrieval info: GEN_FILE: TYPE_NORMAL mult_xy.cmp TRUE
-- Retrieval info: GEN_FILE: TYPE_NORMAL mult_xy.bsf TRUE
-- Retrieval info: GEN_FILE: TYPE_NORMAL mult_xy_inst.vhd FALSE
-- Retrieval info: LIB_FILE: lpm

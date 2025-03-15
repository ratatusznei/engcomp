-- ------------------------------------------------------------------------- 
-- High Level Design Compiler for Intel(R) FPGAs Version 18.1 (Release Build #625)
-- Quartus Prime development tool and MATLAB/Simulink Interface
-- 
-- Legal Notice: Copyright 2018 Intel Corporation.  All rights reserved.
-- Your use of  Intel Corporation's design tools,  logic functions and other
-- software and  tools, and its AMPP partner logic functions, and any output
-- files any  of the foregoing (including  device programming  or simulation
-- files), and  any associated  documentation  or information  are expressly
-- subject  to the terms and  conditions of the  Intel FPGA Software License
-- Agreement, Intel MegaCore Function License Agreement, or other applicable
-- license agreement,  including,  without limitation,  that your use is for
-- the  sole  purpose of  programming  logic devices  manufactured by  Intel
-- and  sold by Intel  or its authorized  distributors. Please refer  to the
-- applicable agreement for further details.
-- ---------------------------------------------------------------------------

-- VHDL created from complex_multiplier
-- VHDL created on Mon Feb 10 21:36:57 2025


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.MATH_REAL.all;
use std.TextIO.all;
use work.dspba_library_package.all;

LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;
LIBRARY lpm;
USE lpm.lpm_components.all;

entity complex_multiplier is
    port (
        a : in std_logic_vector(31 downto 0);  -- float32_m23
        b : in std_logic_vector(31 downto 0);  -- float32_m23
        c : in std_logic_vector(31 downto 0);  -- float32_m23
        d : in std_logic_vector(31 downto 0);  -- float32_m23
        q : out std_logic_vector(31 downto 0);  -- float32_m23
        r : out std_logic_vector(31 downto 0);  -- float32_m23
        clk : in std_logic;
        areset : in std_logic
    );
end complex_multiplier;

architecture normal of complex_multiplier is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal ySign_uid10_fpComplexMulTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal excBits_uid11_fpComplexMulTest_b : STD_LOGIC_VECTOR (1 downto 0);
    signal fraction_uid12_fpComplexMulTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal exp_uid13_fpComplexMulTest_b : STD_LOGIC_VECTOR (7 downto 0);
    signal invYSign_uid14_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal minusY_uid15_fpComplexMulTest_q : STD_LOGIC_VECTOR (33 downto 0);
    signal expX_uid20_ac_uid6_fpComplexMulTest_b : STD_LOGIC_VECTOR (7 downto 0);
    signal expY_uid21_ac_uid6_fpComplexMulTest_b : STD_LOGIC_VECTOR (7 downto 0);
    signal signX_uid22_ac_uid6_fpComplexMulTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal signY_uid23_ac_uid6_fpComplexMulTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal cstAllOWE_uid24_ac_uid6_fpComplexMulTest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal cstZeroWF_uid25_ac_uid6_fpComplexMulTest_q : STD_LOGIC_VECTOR (22 downto 0);
    signal cstAllZWE_uid26_ac_uid6_fpComplexMulTest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal frac_x_uid28_ac_uid6_fpComplexMulTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal excZ_x_uid29_ac_uid6_fpComplexMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excZ_x_uid29_ac_uid6_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expXIsMax_uid30_ac_uid6_fpComplexMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal expXIsMax_uid30_ac_uid6_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsZero_uid31_ac_uid6_fpComplexMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsZero_uid31_ac_uid6_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsNotZero_uid32_ac_uid6_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excI_x_uid33_ac_uid6_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excN_x_uid34_ac_uid6_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal invExpXIsMax_uid35_ac_uid6_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal InvExpXIsZero_uid36_ac_uid6_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excR_x_uid37_ac_uid6_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal frac_y_uid42_ac_uid6_fpComplexMulTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal excZ_y_uid43_ac_uid6_fpComplexMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excZ_y_uid43_ac_uid6_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expXIsMax_uid44_ac_uid6_fpComplexMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal expXIsMax_uid44_ac_uid6_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsZero_uid45_ac_uid6_fpComplexMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsZero_uid45_ac_uid6_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsNotZero_uid46_ac_uid6_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excI_y_uid47_ac_uid6_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excN_y_uid48_ac_uid6_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal invExpXIsMax_uid49_ac_uid6_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal InvExpXIsZero_uid50_ac_uid6_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excR_y_uid51_ac_uid6_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal ofracX_uid54_ac_uid6_fpComplexMulTest_q : STD_LOGIC_VECTOR (23 downto 0);
    signal ofracY_uid57_ac_uid6_fpComplexMulTest_q : STD_LOGIC_VECTOR (23 downto 0);
    signal expSum_uid58_ac_uid6_fpComplexMulTest_a : STD_LOGIC_VECTOR (8 downto 0);
    signal expSum_uid58_ac_uid6_fpComplexMulTest_b : STD_LOGIC_VECTOR (8 downto 0);
    signal expSum_uid58_ac_uid6_fpComplexMulTest_o : STD_LOGIC_VECTOR (8 downto 0);
    signal expSum_uid58_ac_uid6_fpComplexMulTest_q : STD_LOGIC_VECTOR (8 downto 0);
    signal biasInc_uid59_ac_uid6_fpComplexMulTest_q : STD_LOGIC_VECTOR (9 downto 0);
    signal expSumMBias_uid60_ac_uid6_fpComplexMulTest_a : STD_LOGIC_VECTOR (11 downto 0);
    signal expSumMBias_uid60_ac_uid6_fpComplexMulTest_b : STD_LOGIC_VECTOR (11 downto 0);
    signal expSumMBias_uid60_ac_uid6_fpComplexMulTest_o : STD_LOGIC_VECTOR (11 downto 0);
    signal expSumMBias_uid60_ac_uid6_fpComplexMulTest_q : STD_LOGIC_VECTOR (10 downto 0);
    signal signR_uid62_ac_uid6_fpComplexMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal signR_uid62_ac_uid6_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal normalizeBit_uid63_ac_uid6_fpComplexMulTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal fracRPostNormHigh_uid65_ac_uid6_fpComplexMulTest_in : STD_LOGIC_VECTOR (46 downto 0);
    signal fracRPostNormHigh_uid65_ac_uid6_fpComplexMulTest_b : STD_LOGIC_VECTOR (23 downto 0);
    signal fracRPostNormLow_uid66_ac_uid6_fpComplexMulTest_in : STD_LOGIC_VECTOR (45 downto 0);
    signal fracRPostNormLow_uid66_ac_uid6_fpComplexMulTest_b : STD_LOGIC_VECTOR (23 downto 0);
    signal fracRPostNorm_uid67_ac_uid6_fpComplexMulTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fracRPostNorm_uid67_ac_uid6_fpComplexMulTest_q : STD_LOGIC_VECTOR (23 downto 0);
    signal stickyRange_uid68_ac_uid6_fpComplexMulTest_in : STD_LOGIC_VECTOR (21 downto 0);
    signal stickyRange_uid68_ac_uid6_fpComplexMulTest_b : STD_LOGIC_VECTOR (21 downto 0);
    signal extraStickyBitOfProd_uid69_ac_uid6_fpComplexMulTest_in : STD_LOGIC_VECTOR (22 downto 0);
    signal extraStickyBitOfProd_uid69_ac_uid6_fpComplexMulTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal extraStickyBit_uid70_ac_uid6_fpComplexMulTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal extraStickyBit_uid70_ac_uid6_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal stickyExtendedRange_uid71_ac_uid6_fpComplexMulTest_q : STD_LOGIC_VECTOR (22 downto 0);
    signal stickyRangeComparator_uid73_ac_uid6_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal sticky_uid74_ac_uid6_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracRPostNorm1dto0_uid75_ac_uid6_fpComplexMulTest_in : STD_LOGIC_VECTOR (1 downto 0);
    signal fracRPostNorm1dto0_uid75_ac_uid6_fpComplexMulTest_b : STD_LOGIC_VECTOR (1 downto 0);
    signal lrs_uid76_ac_uid6_fpComplexMulTest_q : STD_LOGIC_VECTOR (2 downto 0);
    signal roundBitDetectionConstant_uid77_ac_uid6_fpComplexMulTest_q : STD_LOGIC_VECTOR (2 downto 0);
    signal roundBitDetectionPattern_uid78_ac_uid6_fpComplexMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal roundBitDetectionPattern_uid78_ac_uid6_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal roundBit_uid79_ac_uid6_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expFracPreRound_uid80_ac_uid6_fpComplexMulTest_q : STD_LOGIC_VECTOR (34 downto 0);
    signal roundBitAndNormalizationOp_uid82_ac_uid6_fpComplexMulTest_q : STD_LOGIC_VECTOR (25 downto 0);
    signal expFracRPostRounding_uid83_ac_uid6_fpComplexMulTest_a : STD_LOGIC_VECTOR (36 downto 0);
    signal expFracRPostRounding_uid83_ac_uid6_fpComplexMulTest_b : STD_LOGIC_VECTOR (36 downto 0);
    signal expFracRPostRounding_uid83_ac_uid6_fpComplexMulTest_o : STD_LOGIC_VECTOR (36 downto 0);
    signal expFracRPostRounding_uid83_ac_uid6_fpComplexMulTest_q : STD_LOGIC_VECTOR (35 downto 0);
    signal fracRPreExc_uid84_ac_uid6_fpComplexMulTest_in : STD_LOGIC_VECTOR (23 downto 0);
    signal fracRPreExc_uid84_ac_uid6_fpComplexMulTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal expRPreExcExt_uid85_ac_uid6_fpComplexMulTest_b : STD_LOGIC_VECTOR (11 downto 0);
    signal expRPreExc_uid86_ac_uid6_fpComplexMulTest_in : STD_LOGIC_VECTOR (7 downto 0);
    signal expRPreExc_uid86_ac_uid6_fpComplexMulTest_b : STD_LOGIC_VECTOR (7 downto 0);
    signal expOvf_uid89_ac_uid6_fpComplexMulTest_a : STD_LOGIC_VECTOR (13 downto 0);
    signal expOvf_uid89_ac_uid6_fpComplexMulTest_b : STD_LOGIC_VECTOR (13 downto 0);
    signal expOvf_uid89_ac_uid6_fpComplexMulTest_o : STD_LOGIC_VECTOR (13 downto 0);
    signal expOvf_uid89_ac_uid6_fpComplexMulTest_c : STD_LOGIC_VECTOR (0 downto 0);
    signal excXZAndExcYZ_uid90_ac_uid6_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excXZAndExcYR_uid91_ac_uid6_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excYZAndExcXR_uid92_ac_uid6_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excZC3_uid93_ac_uid6_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excRZero_uid94_ac_uid6_fpComplexMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excRZero_uid94_ac_uid6_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excXIAndExcYI_uid95_ac_uid6_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excXRAndExcYI_uid96_ac_uid6_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excYRAndExcXI_uid97_ac_uid6_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal ExcROvfAndInReg_uid98_ac_uid6_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excRInf_uid99_ac_uid6_fpComplexMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excRInf_uid99_ac_uid6_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excYZAndExcXI_uid100_ac_uid6_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excXZAndExcYI_uid101_ac_uid6_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal ZeroTimesInf_uid102_ac_uid6_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excRNaN_uid103_ac_uid6_fpComplexMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excRNaN_uid103_ac_uid6_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal concExc_uid104_ac_uid6_fpComplexMulTest_q : STD_LOGIC_VECTOR (2 downto 0);
    signal excREnc_uid105_ac_uid6_fpComplexMulTest_q : STD_LOGIC_VECTOR (1 downto 0);
    signal invExcRNaN_uid106_ac_uid6_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal signRPostExc_uid107_ac_uid6_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal R_uid108_ac_uid6_fpComplexMulTest_q : STD_LOGIC_VECTOR (33 downto 0);
    signal expX_uid110_bd_uid7_fpComplexMulTest_b : STD_LOGIC_VECTOR (7 downto 0);
    signal expY_uid111_bd_uid7_fpComplexMulTest_b : STD_LOGIC_VECTOR (7 downto 0);
    signal signX_uid112_bd_uid7_fpComplexMulTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal signY_uid113_bd_uid7_fpComplexMulTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal frac_x_uid118_bd_uid7_fpComplexMulTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal excZ_x_uid119_bd_uid7_fpComplexMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excZ_x_uid119_bd_uid7_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expXIsMax_uid120_bd_uid7_fpComplexMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal expXIsMax_uid120_bd_uid7_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsZero_uid121_bd_uid7_fpComplexMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsZero_uid121_bd_uid7_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsNotZero_uid122_bd_uid7_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excI_x_uid123_bd_uid7_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excN_x_uid124_bd_uid7_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal invExpXIsMax_uid125_bd_uid7_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal InvExpXIsZero_uid126_bd_uid7_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excR_x_uid127_bd_uid7_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal frac_y_uid132_bd_uid7_fpComplexMulTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal excZ_y_uid133_bd_uid7_fpComplexMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excZ_y_uid133_bd_uid7_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expXIsMax_uid134_bd_uid7_fpComplexMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal expXIsMax_uid134_bd_uid7_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsZero_uid135_bd_uid7_fpComplexMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsZero_uid135_bd_uid7_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsNotZero_uid136_bd_uid7_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excI_y_uid137_bd_uid7_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excN_y_uid138_bd_uid7_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal invExpXIsMax_uid139_bd_uid7_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal InvExpXIsZero_uid140_bd_uid7_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excR_y_uid141_bd_uid7_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal ofracX_uid144_bd_uid7_fpComplexMulTest_q : STD_LOGIC_VECTOR (23 downto 0);
    signal ofracY_uid147_bd_uid7_fpComplexMulTest_q : STD_LOGIC_VECTOR (23 downto 0);
    signal expSum_uid148_bd_uid7_fpComplexMulTest_a : STD_LOGIC_VECTOR (8 downto 0);
    signal expSum_uid148_bd_uid7_fpComplexMulTest_b : STD_LOGIC_VECTOR (8 downto 0);
    signal expSum_uid148_bd_uid7_fpComplexMulTest_o : STD_LOGIC_VECTOR (8 downto 0);
    signal expSum_uid148_bd_uid7_fpComplexMulTest_q : STD_LOGIC_VECTOR (8 downto 0);
    signal expSumMBias_uid150_bd_uid7_fpComplexMulTest_a : STD_LOGIC_VECTOR (11 downto 0);
    signal expSumMBias_uid150_bd_uid7_fpComplexMulTest_b : STD_LOGIC_VECTOR (11 downto 0);
    signal expSumMBias_uid150_bd_uid7_fpComplexMulTest_o : STD_LOGIC_VECTOR (11 downto 0);
    signal expSumMBias_uid150_bd_uid7_fpComplexMulTest_q : STD_LOGIC_VECTOR (10 downto 0);
    signal signR_uid152_bd_uid7_fpComplexMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal signR_uid152_bd_uid7_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal normalizeBit_uid153_bd_uid7_fpComplexMulTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal fracRPostNormHigh_uid155_bd_uid7_fpComplexMulTest_in : STD_LOGIC_VECTOR (46 downto 0);
    signal fracRPostNormHigh_uid155_bd_uid7_fpComplexMulTest_b : STD_LOGIC_VECTOR (23 downto 0);
    signal fracRPostNormLow_uid156_bd_uid7_fpComplexMulTest_in : STD_LOGIC_VECTOR (45 downto 0);
    signal fracRPostNormLow_uid156_bd_uid7_fpComplexMulTest_b : STD_LOGIC_VECTOR (23 downto 0);
    signal fracRPostNorm_uid157_bd_uid7_fpComplexMulTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fracRPostNorm_uid157_bd_uid7_fpComplexMulTest_q : STD_LOGIC_VECTOR (23 downto 0);
    signal stickyRange_uid158_bd_uid7_fpComplexMulTest_in : STD_LOGIC_VECTOR (21 downto 0);
    signal stickyRange_uid158_bd_uid7_fpComplexMulTest_b : STD_LOGIC_VECTOR (21 downto 0);
    signal extraStickyBitOfProd_uid159_bd_uid7_fpComplexMulTest_in : STD_LOGIC_VECTOR (22 downto 0);
    signal extraStickyBitOfProd_uid159_bd_uid7_fpComplexMulTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal extraStickyBit_uid160_bd_uid7_fpComplexMulTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal extraStickyBit_uid160_bd_uid7_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal stickyExtendedRange_uid161_bd_uid7_fpComplexMulTest_q : STD_LOGIC_VECTOR (22 downto 0);
    signal stickyRangeComparator_uid163_bd_uid7_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal sticky_uid164_bd_uid7_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracRPostNorm1dto0_uid165_bd_uid7_fpComplexMulTest_in : STD_LOGIC_VECTOR (1 downto 0);
    signal fracRPostNorm1dto0_uid165_bd_uid7_fpComplexMulTest_b : STD_LOGIC_VECTOR (1 downto 0);
    signal lrs_uid166_bd_uid7_fpComplexMulTest_q : STD_LOGIC_VECTOR (2 downto 0);
    signal roundBitDetectionPattern_uid168_bd_uid7_fpComplexMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal roundBitDetectionPattern_uid168_bd_uid7_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal roundBit_uid169_bd_uid7_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expFracPreRound_uid170_bd_uid7_fpComplexMulTest_q : STD_LOGIC_VECTOR (34 downto 0);
    signal roundBitAndNormalizationOp_uid172_bd_uid7_fpComplexMulTest_q : STD_LOGIC_VECTOR (25 downto 0);
    signal expFracRPostRounding_uid173_bd_uid7_fpComplexMulTest_a : STD_LOGIC_VECTOR (36 downto 0);
    signal expFracRPostRounding_uid173_bd_uid7_fpComplexMulTest_b : STD_LOGIC_VECTOR (36 downto 0);
    signal expFracRPostRounding_uid173_bd_uid7_fpComplexMulTest_o : STD_LOGIC_VECTOR (36 downto 0);
    signal expFracRPostRounding_uid173_bd_uid7_fpComplexMulTest_q : STD_LOGIC_VECTOR (35 downto 0);
    signal fracRPreExc_uid174_bd_uid7_fpComplexMulTest_in : STD_LOGIC_VECTOR (23 downto 0);
    signal fracRPreExc_uid174_bd_uid7_fpComplexMulTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal expRPreExcExt_uid175_bd_uid7_fpComplexMulTest_b : STD_LOGIC_VECTOR (11 downto 0);
    signal expRPreExc_uid176_bd_uid7_fpComplexMulTest_in : STD_LOGIC_VECTOR (7 downto 0);
    signal expRPreExc_uid176_bd_uid7_fpComplexMulTest_b : STD_LOGIC_VECTOR (7 downto 0);
    signal expOvf_uid179_bd_uid7_fpComplexMulTest_a : STD_LOGIC_VECTOR (13 downto 0);
    signal expOvf_uid179_bd_uid7_fpComplexMulTest_b : STD_LOGIC_VECTOR (13 downto 0);
    signal expOvf_uid179_bd_uid7_fpComplexMulTest_o : STD_LOGIC_VECTOR (13 downto 0);
    signal expOvf_uid179_bd_uid7_fpComplexMulTest_c : STD_LOGIC_VECTOR (0 downto 0);
    signal excXZAndExcYZ_uid180_bd_uid7_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excXZAndExcYR_uid181_bd_uid7_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excYZAndExcXR_uid182_bd_uid7_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excZC3_uid183_bd_uid7_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excRZero_uid184_bd_uid7_fpComplexMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excRZero_uid184_bd_uid7_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excXIAndExcYI_uid185_bd_uid7_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excXRAndExcYI_uid186_bd_uid7_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excYRAndExcXI_uid187_bd_uid7_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal ExcROvfAndInReg_uid188_bd_uid7_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excRInf_uid189_bd_uid7_fpComplexMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excRInf_uid189_bd_uid7_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excYZAndExcXI_uid190_bd_uid7_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excXZAndExcYI_uid191_bd_uid7_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal ZeroTimesInf_uid192_bd_uid7_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excRNaN_uid193_bd_uid7_fpComplexMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excRNaN_uid193_bd_uid7_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal concExc_uid194_bd_uid7_fpComplexMulTest_q : STD_LOGIC_VECTOR (2 downto 0);
    signal excREnc_uid195_bd_uid7_fpComplexMulTest_q : STD_LOGIC_VECTOR (1 downto 0);
    signal invExcRNaN_uid196_bd_uid7_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal signRPostExc_uid197_bd_uid7_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal R_uid198_bd_uid7_fpComplexMulTest_q : STD_LOGIC_VECTOR (33 downto 0);
    signal expSum_uid238_ad_uid8_fpComplexMulTest_a : STD_LOGIC_VECTOR (8 downto 0);
    signal expSum_uid238_ad_uid8_fpComplexMulTest_b : STD_LOGIC_VECTOR (8 downto 0);
    signal expSum_uid238_ad_uid8_fpComplexMulTest_o : STD_LOGIC_VECTOR (8 downto 0);
    signal expSum_uid238_ad_uid8_fpComplexMulTest_q : STD_LOGIC_VECTOR (8 downto 0);
    signal expSumMBias_uid240_ad_uid8_fpComplexMulTest_a : STD_LOGIC_VECTOR (11 downto 0);
    signal expSumMBias_uid240_ad_uid8_fpComplexMulTest_b : STD_LOGIC_VECTOR (11 downto 0);
    signal expSumMBias_uid240_ad_uid8_fpComplexMulTest_o : STD_LOGIC_VECTOR (11 downto 0);
    signal expSumMBias_uid240_ad_uid8_fpComplexMulTest_q : STD_LOGIC_VECTOR (10 downto 0);
    signal signR_uid242_ad_uid8_fpComplexMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal signR_uid242_ad_uid8_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal normalizeBit_uid243_ad_uid8_fpComplexMulTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal fracRPostNormHigh_uid245_ad_uid8_fpComplexMulTest_in : STD_LOGIC_VECTOR (46 downto 0);
    signal fracRPostNormHigh_uid245_ad_uid8_fpComplexMulTest_b : STD_LOGIC_VECTOR (23 downto 0);
    signal fracRPostNormLow_uid246_ad_uid8_fpComplexMulTest_in : STD_LOGIC_VECTOR (45 downto 0);
    signal fracRPostNormLow_uid246_ad_uid8_fpComplexMulTest_b : STD_LOGIC_VECTOR (23 downto 0);
    signal fracRPostNorm_uid247_ad_uid8_fpComplexMulTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fracRPostNorm_uid247_ad_uid8_fpComplexMulTest_q : STD_LOGIC_VECTOR (23 downto 0);
    signal stickyRange_uid248_ad_uid8_fpComplexMulTest_in : STD_LOGIC_VECTOR (21 downto 0);
    signal stickyRange_uid248_ad_uid8_fpComplexMulTest_b : STD_LOGIC_VECTOR (21 downto 0);
    signal extraStickyBitOfProd_uid249_ad_uid8_fpComplexMulTest_in : STD_LOGIC_VECTOR (22 downto 0);
    signal extraStickyBitOfProd_uid249_ad_uid8_fpComplexMulTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal extraStickyBit_uid250_ad_uid8_fpComplexMulTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal extraStickyBit_uid250_ad_uid8_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal stickyExtendedRange_uid251_ad_uid8_fpComplexMulTest_q : STD_LOGIC_VECTOR (22 downto 0);
    signal stickyRangeComparator_uid253_ad_uid8_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal sticky_uid254_ad_uid8_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracRPostNorm1dto0_uid255_ad_uid8_fpComplexMulTest_in : STD_LOGIC_VECTOR (1 downto 0);
    signal fracRPostNorm1dto0_uid255_ad_uid8_fpComplexMulTest_b : STD_LOGIC_VECTOR (1 downto 0);
    signal lrs_uid256_ad_uid8_fpComplexMulTest_q : STD_LOGIC_VECTOR (2 downto 0);
    signal roundBitDetectionPattern_uid258_ad_uid8_fpComplexMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal roundBitDetectionPattern_uid258_ad_uid8_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal roundBit_uid259_ad_uid8_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expFracPreRound_uid260_ad_uid8_fpComplexMulTest_q : STD_LOGIC_VECTOR (34 downto 0);
    signal roundBitAndNormalizationOp_uid262_ad_uid8_fpComplexMulTest_q : STD_LOGIC_VECTOR (25 downto 0);
    signal expFracRPostRounding_uid263_ad_uid8_fpComplexMulTest_a : STD_LOGIC_VECTOR (36 downto 0);
    signal expFracRPostRounding_uid263_ad_uid8_fpComplexMulTest_b : STD_LOGIC_VECTOR (36 downto 0);
    signal expFracRPostRounding_uid263_ad_uid8_fpComplexMulTest_o : STD_LOGIC_VECTOR (36 downto 0);
    signal expFracRPostRounding_uid263_ad_uid8_fpComplexMulTest_q : STD_LOGIC_VECTOR (35 downto 0);
    signal fracRPreExc_uid264_ad_uid8_fpComplexMulTest_in : STD_LOGIC_VECTOR (23 downto 0);
    signal fracRPreExc_uid264_ad_uid8_fpComplexMulTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal expRPreExcExt_uid265_ad_uid8_fpComplexMulTest_b : STD_LOGIC_VECTOR (11 downto 0);
    signal expRPreExc_uid266_ad_uid8_fpComplexMulTest_in : STD_LOGIC_VECTOR (7 downto 0);
    signal expRPreExc_uid266_ad_uid8_fpComplexMulTest_b : STD_LOGIC_VECTOR (7 downto 0);
    signal expOvf_uid269_ad_uid8_fpComplexMulTest_a : STD_LOGIC_VECTOR (13 downto 0);
    signal expOvf_uid269_ad_uid8_fpComplexMulTest_b : STD_LOGIC_VECTOR (13 downto 0);
    signal expOvf_uid269_ad_uid8_fpComplexMulTest_o : STD_LOGIC_VECTOR (13 downto 0);
    signal expOvf_uid269_ad_uid8_fpComplexMulTest_c : STD_LOGIC_VECTOR (0 downto 0);
    signal excXZAndExcYZ_uid270_ad_uid8_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excXZAndExcYR_uid271_ad_uid8_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excYZAndExcXR_uid272_ad_uid8_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excZC3_uid273_ad_uid8_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excRZero_uid274_ad_uid8_fpComplexMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excRZero_uid274_ad_uid8_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excXIAndExcYI_uid275_ad_uid8_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excXRAndExcYI_uid276_ad_uid8_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excYRAndExcXI_uid277_ad_uid8_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal ExcROvfAndInReg_uid278_ad_uid8_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excRInf_uid279_ad_uid8_fpComplexMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excRInf_uid279_ad_uid8_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excYZAndExcXI_uid280_ad_uid8_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excXZAndExcYI_uid281_ad_uid8_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal ZeroTimesInf_uid282_ad_uid8_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excRNaN_uid283_ad_uid8_fpComplexMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excRNaN_uid283_ad_uid8_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal concExc_uid284_ad_uid8_fpComplexMulTest_q : STD_LOGIC_VECTOR (2 downto 0);
    signal excREnc_uid285_ad_uid8_fpComplexMulTest_q : STD_LOGIC_VECTOR (1 downto 0);
    signal invExcRNaN_uid286_ad_uid8_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal signRPostExc_uid287_ad_uid8_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal R_uid288_ad_uid8_fpComplexMulTest_q : STD_LOGIC_VECTOR (33 downto 0);
    signal expSum_uid328_bc_uid9_fpComplexMulTest_a : STD_LOGIC_VECTOR (8 downto 0);
    signal expSum_uid328_bc_uid9_fpComplexMulTest_b : STD_LOGIC_VECTOR (8 downto 0);
    signal expSum_uid328_bc_uid9_fpComplexMulTest_o : STD_LOGIC_VECTOR (8 downto 0);
    signal expSum_uid328_bc_uid9_fpComplexMulTest_q : STD_LOGIC_VECTOR (8 downto 0);
    signal expSumMBias_uid330_bc_uid9_fpComplexMulTest_a : STD_LOGIC_VECTOR (11 downto 0);
    signal expSumMBias_uid330_bc_uid9_fpComplexMulTest_b : STD_LOGIC_VECTOR (11 downto 0);
    signal expSumMBias_uid330_bc_uid9_fpComplexMulTest_o : STD_LOGIC_VECTOR (11 downto 0);
    signal expSumMBias_uid330_bc_uid9_fpComplexMulTest_q : STD_LOGIC_VECTOR (10 downto 0);
    signal signR_uid332_bc_uid9_fpComplexMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal signR_uid332_bc_uid9_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal normalizeBit_uid333_bc_uid9_fpComplexMulTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal fracRPostNormHigh_uid335_bc_uid9_fpComplexMulTest_in : STD_LOGIC_VECTOR (46 downto 0);
    signal fracRPostNormHigh_uid335_bc_uid9_fpComplexMulTest_b : STD_LOGIC_VECTOR (23 downto 0);
    signal fracRPostNormLow_uid336_bc_uid9_fpComplexMulTest_in : STD_LOGIC_VECTOR (45 downto 0);
    signal fracRPostNormLow_uid336_bc_uid9_fpComplexMulTest_b : STD_LOGIC_VECTOR (23 downto 0);
    signal fracRPostNorm_uid337_bc_uid9_fpComplexMulTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fracRPostNorm_uid337_bc_uid9_fpComplexMulTest_q : STD_LOGIC_VECTOR (23 downto 0);
    signal stickyRange_uid338_bc_uid9_fpComplexMulTest_in : STD_LOGIC_VECTOR (21 downto 0);
    signal stickyRange_uid338_bc_uid9_fpComplexMulTest_b : STD_LOGIC_VECTOR (21 downto 0);
    signal extraStickyBitOfProd_uid339_bc_uid9_fpComplexMulTest_in : STD_LOGIC_VECTOR (22 downto 0);
    signal extraStickyBitOfProd_uid339_bc_uid9_fpComplexMulTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal extraStickyBit_uid340_bc_uid9_fpComplexMulTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal extraStickyBit_uid340_bc_uid9_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal stickyExtendedRange_uid341_bc_uid9_fpComplexMulTest_q : STD_LOGIC_VECTOR (22 downto 0);
    signal stickyRangeComparator_uid343_bc_uid9_fpComplexMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal stickyRangeComparator_uid343_bc_uid9_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal sticky_uid344_bc_uid9_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracRPostNorm1dto0_uid345_bc_uid9_fpComplexMulTest_in : STD_LOGIC_VECTOR (1 downto 0);
    signal fracRPostNorm1dto0_uid345_bc_uid9_fpComplexMulTest_b : STD_LOGIC_VECTOR (1 downto 0);
    signal lrs_uid346_bc_uid9_fpComplexMulTest_q : STD_LOGIC_VECTOR (2 downto 0);
    signal roundBitDetectionPattern_uid348_bc_uid9_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal roundBit_uid349_bc_uid9_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expFracPreRound_uid350_bc_uid9_fpComplexMulTest_q : STD_LOGIC_VECTOR (34 downto 0);
    signal roundBitAndNormalizationOp_uid352_bc_uid9_fpComplexMulTest_q : STD_LOGIC_VECTOR (25 downto 0);
    signal expFracRPostRounding_uid353_bc_uid9_fpComplexMulTest_a : STD_LOGIC_VECTOR (36 downto 0);
    signal expFracRPostRounding_uid353_bc_uid9_fpComplexMulTest_b : STD_LOGIC_VECTOR (36 downto 0);
    signal expFracRPostRounding_uid353_bc_uid9_fpComplexMulTest_o : STD_LOGIC_VECTOR (36 downto 0);
    signal expFracRPostRounding_uid353_bc_uid9_fpComplexMulTest_q : STD_LOGIC_VECTOR (35 downto 0);
    signal fracRPreExc_uid354_bc_uid9_fpComplexMulTest_in : STD_LOGIC_VECTOR (23 downto 0);
    signal fracRPreExc_uid354_bc_uid9_fpComplexMulTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal expRPreExcExt_uid355_bc_uid9_fpComplexMulTest_b : STD_LOGIC_VECTOR (11 downto 0);
    signal expRPreExc_uid356_bc_uid9_fpComplexMulTest_in : STD_LOGIC_VECTOR (7 downto 0);
    signal expRPreExc_uid356_bc_uid9_fpComplexMulTest_b : STD_LOGIC_VECTOR (7 downto 0);
    signal expOvf_uid359_bc_uid9_fpComplexMulTest_a : STD_LOGIC_VECTOR (13 downto 0);
    signal expOvf_uid359_bc_uid9_fpComplexMulTest_b : STD_LOGIC_VECTOR (13 downto 0);
    signal expOvf_uid359_bc_uid9_fpComplexMulTest_o : STD_LOGIC_VECTOR (13 downto 0);
    signal expOvf_uid359_bc_uid9_fpComplexMulTest_c : STD_LOGIC_VECTOR (0 downto 0);
    signal excXZAndExcYZ_uid360_bc_uid9_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excXZAndExcYR_uid361_bc_uid9_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excYZAndExcXR_uid362_bc_uid9_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excZC3_uid363_bc_uid9_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excRZero_uid364_bc_uid9_fpComplexMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excRZero_uid364_bc_uid9_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excXIAndExcYI_uid365_bc_uid9_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excXRAndExcYI_uid366_bc_uid9_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excYRAndExcXI_uid367_bc_uid9_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal ExcROvfAndInReg_uid368_bc_uid9_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excRInf_uid369_bc_uid9_fpComplexMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excRInf_uid369_bc_uid9_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excYZAndExcXI_uid370_bc_uid9_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excXZAndExcYI_uid371_bc_uid9_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal ZeroTimesInf_uid372_bc_uid9_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excRNaN_uid373_bc_uid9_fpComplexMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excRNaN_uid373_bc_uid9_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal concExc_uid374_bc_uid9_fpComplexMulTest_q : STD_LOGIC_VECTOR (2 downto 0);
    signal excREnc_uid375_bc_uid9_fpComplexMulTest_q : STD_LOGIC_VECTOR (1 downto 0);
    signal invExcRNaN_uid376_bc_uid9_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal signRPostExc_uid377_bc_uid9_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal R_uid378_bc_uid9_fpComplexMulTest_q : STD_LOGIC_VECTOR (33 downto 0);
    signal excX_uid385_rReal_uid16_fpComplexMulTest_b : STD_LOGIC_VECTOR (1 downto 0);
    signal zero2b_uid386_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (1 downto 0);
    signal one2b_uid387_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (1 downto 0);
    signal two2b_uid388_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (1 downto 0);
    signal three2b_uid389_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (1 downto 0);
    signal excXZero_uid390_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excXReg_uid391_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excXInf_uid392_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excXNaN_uid393_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excX_uid399_rReal_uid16_fpComplexMulTest_b : STD_LOGIC_VECTOR (1 downto 0);
    signal excXZero_uid404_rReal_uid16_fpComplexMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excXZero_uid404_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excXReg_uid405_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excXInf_uid406_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excXNaN_uid407_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expFracX_uid408_rReal_uid16_fpComplexMulTest_b : STD_LOGIC_VECTOR (30 downto 0);
    signal expFracY_uid409_rReal_uid16_fpComplexMulTest_in : STD_LOGIC_VECTOR (30 downto 0);
    signal expFracY_uid409_rReal_uid16_fpComplexMulTest_b : STD_LOGIC_VECTOR (30 downto 0);
    signal xGTEy_uid410_rReal_uid16_fpComplexMulTest_a : STD_LOGIC_VECTOR (32 downto 0);
    signal xGTEy_uid410_rReal_uid16_fpComplexMulTest_b : STD_LOGIC_VECTOR (32 downto 0);
    signal xGTEy_uid410_rReal_uid16_fpComplexMulTest_o : STD_LOGIC_VECTOR (32 downto 0);
    signal xGTEy_uid410_rReal_uid16_fpComplexMulTest_n : STD_LOGIC_VECTOR (0 downto 0);
    signal xGTEyOrYz_uid411_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal invExcXZ_uid412_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal xGTEy_uid413_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracY_uid414_rReal_uid16_fpComplexMulTest_in : STD_LOGIC_VECTOR (22 downto 0);
    signal fracY_uid414_rReal_uid16_fpComplexMulTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal expY_uid415_rReal_uid16_fpComplexMulTest_in : STD_LOGIC_VECTOR (30 downto 0);
    signal expY_uid415_rReal_uid16_fpComplexMulTest_b : STD_LOGIC_VECTOR (7 downto 0);
    signal sigY_uid416_rReal_uid16_fpComplexMulTest_in : STD_LOGIC_VECTOR (31 downto 0);
    signal sigY_uid416_rReal_uid16_fpComplexMulTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal ypn_uid417_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (31 downto 0);
    signal xMuxRange_uid419_rReal_uid16_fpComplexMulTest_in : STD_LOGIC_VECTOR (31 downto 0);
    signal xMuxRange_uid419_rReal_uid16_fpComplexMulTest_b : STD_LOGIC_VECTOR (31 downto 0);
    signal aSig_uid421_rReal_uid16_fpComplexMulTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aSig_uid421_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (31 downto 0);
    signal bSig_uid422_rReal_uid16_fpComplexMulTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal bSig_uid422_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (31 downto 0);
    signal excAI_uid423_rReal_uid16_fpComplexMulTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal excAI_uid423_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excAN_uid424_rReal_uid16_fpComplexMulTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal excAN_uid424_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excAR_uid425_rReal_uid16_fpComplexMulTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal excAR_uid425_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excAZ_uid426_rReal_uid16_fpComplexMulTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal excAZ_uid426_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excBI_uid427_rReal_uid16_fpComplexMulTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal excBI_uid427_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excBN_uid428_rReal_uid16_fpComplexMulTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal excBN_uid428_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excBR_uid429_rReal_uid16_fpComplexMulTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal excBR_uid429_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excBZ_uid430_rReal_uid16_fpComplexMulTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal excBZ_uid430_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expA_uid431_rReal_uid16_fpComplexMulTest_in : STD_LOGIC_VECTOR (30 downto 0);
    signal expA_uid431_rReal_uid16_fpComplexMulTest_b : STD_LOGIC_VECTOR (7 downto 0);
    signal expB_uid432_rReal_uid16_fpComplexMulTest_in : STD_LOGIC_VECTOR (30 downto 0);
    signal expB_uid432_rReal_uid16_fpComplexMulTest_b : STD_LOGIC_VECTOR (7 downto 0);
    signal fracA_uid433_rReal_uid16_fpComplexMulTest_in : STD_LOGIC_VECTOR (22 downto 0);
    signal fracA_uid433_rReal_uid16_fpComplexMulTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal fracB_uid434_rReal_uid16_fpComplexMulTest_in : STD_LOGIC_VECTOR (22 downto 0);
    signal fracB_uid434_rReal_uid16_fpComplexMulTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal sigA_uid435_rReal_uid16_fpComplexMulTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal sigB_uid436_rReal_uid16_fpComplexMulTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal effSub_uid437_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracBz_uid443_rReal_uid16_fpComplexMulTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fracBz_uid443_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (22 downto 0);
    signal invExcBZ_uid445_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal oFracB_uid446_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (23 downto 0);
    signal expAmExpB_uid447_rReal_uid16_fpComplexMulTest_a : STD_LOGIC_VECTOR (8 downto 0);
    signal expAmExpB_uid447_rReal_uid16_fpComplexMulTest_b : STD_LOGIC_VECTOR (8 downto 0);
    signal expAmExpB_uid447_rReal_uid16_fpComplexMulTest_i : STD_LOGIC_VECTOR (8 downto 0);
    signal expAmExpB_uid447_rReal_uid16_fpComplexMulTest_o : STD_LOGIC_VECTOR (8 downto 0);
    signal expAmExpB_uid447_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (8 downto 0);
    signal cWFP2_uid448_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (4 downto 0);
    signal shiftedOut_uid450_rReal_uid16_fpComplexMulTest_a : STD_LOGIC_VECTOR (10 downto 0);
    signal shiftedOut_uid450_rReal_uid16_fpComplexMulTest_b : STD_LOGIC_VECTOR (10 downto 0);
    signal shiftedOut_uid450_rReal_uid16_fpComplexMulTest_o : STD_LOGIC_VECTOR (10 downto 0);
    signal shiftedOut_uid450_rReal_uid16_fpComplexMulTest_c : STD_LOGIC_VECTOR (0 downto 0);
    signal padConst_uid451_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (24 downto 0);
    signal rightPaddedIn_uid452_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (48 downto 0);
    signal iShiftedOut_uid454_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal alignFracBPostShiftOut_uid455_rReal_uid16_fpComplexMulTest_b : STD_LOGIC_VECTOR (48 downto 0);
    signal alignFracBPostShiftOut_uid455_rReal_uid16_fpComplexMulTest_qi : STD_LOGIC_VECTOR (48 downto 0);
    signal alignFracBPostShiftOut_uid455_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (48 downto 0);
    signal cmpEQ_stickyBits_cZwF_uid458_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal invCmpEQ_stickyBits_cZwF_uid459_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal effSubInvSticky_uid461_rReal_uid16_fpComplexMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal effSubInvSticky_uid461_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracAAddOp_uid464_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (26 downto 0);
    signal fracBAddOp_uid467_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (26 downto 0);
    signal fracBAddOpPostXor_uid468_rReal_uid16_fpComplexMulTest_b : STD_LOGIC_VECTOR (26 downto 0);
    signal fracBAddOpPostXor_uid468_rReal_uid16_fpComplexMulTest_qi : STD_LOGIC_VECTOR (26 downto 0);
    signal fracBAddOpPostXor_uid468_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (26 downto 0);
    signal fracAddResult_uid469_rReal_uid16_fpComplexMulTest_a : STD_LOGIC_VECTOR (27 downto 0);
    signal fracAddResult_uid469_rReal_uid16_fpComplexMulTest_b : STD_LOGIC_VECTOR (27 downto 0);
    signal fracAddResult_uid469_rReal_uid16_fpComplexMulTest_o : STD_LOGIC_VECTOR (27 downto 0);
    signal fracAddResult_uid469_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (27 downto 0);
    signal rangeFracAddResultMwfp3Dto0_uid470_rReal_uid16_fpComplexMulTest_in : STD_LOGIC_VECTOR (26 downto 0);
    signal rangeFracAddResultMwfp3Dto0_uid470_rReal_uid16_fpComplexMulTest_b : STD_LOGIC_VECTOR (26 downto 0);
    signal fracGRS_uid471_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (27 downto 0);
    signal cAmA_uid473_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (4 downto 0);
    signal aMinusA_uid474_rReal_uid16_fpComplexMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal aMinusA_uid474_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracPostNorm_uid476_rReal_uid16_fpComplexMulTest_b : STD_LOGIC_VECTOR (26 downto 0);
    signal oneCST_uid477_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal expInc_uid478_rReal_uid16_fpComplexMulTest_a : STD_LOGIC_VECTOR (8 downto 0);
    signal expInc_uid478_rReal_uid16_fpComplexMulTest_b : STD_LOGIC_VECTOR (8 downto 0);
    signal expInc_uid478_rReal_uid16_fpComplexMulTest_o : STD_LOGIC_VECTOR (8 downto 0);
    signal expInc_uid478_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (8 downto 0);
    signal expPostNorm_uid479_rReal_uid16_fpComplexMulTest_a : STD_LOGIC_VECTOR (9 downto 0);
    signal expPostNorm_uid479_rReal_uid16_fpComplexMulTest_b : STD_LOGIC_VECTOR (9 downto 0);
    signal expPostNorm_uid479_rReal_uid16_fpComplexMulTest_o : STD_LOGIC_VECTOR (9 downto 0);
    signal expPostNorm_uid479_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (9 downto 0);
    signal Sticky0_uid480_rReal_uid16_fpComplexMulTest_in : STD_LOGIC_VECTOR (0 downto 0);
    signal Sticky0_uid480_rReal_uid16_fpComplexMulTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal Sticky1_uid481_rReal_uid16_fpComplexMulTest_in : STD_LOGIC_VECTOR (1 downto 0);
    signal Sticky1_uid481_rReal_uid16_fpComplexMulTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal Round_uid482_rReal_uid16_fpComplexMulTest_in : STD_LOGIC_VECTOR (2 downto 0);
    signal Round_uid482_rReal_uid16_fpComplexMulTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal Guard_uid483_rReal_uid16_fpComplexMulTest_in : STD_LOGIC_VECTOR (3 downto 0);
    signal Guard_uid483_rReal_uid16_fpComplexMulTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal LSB_uid484_rReal_uid16_fpComplexMulTest_in : STD_LOGIC_VECTOR (4 downto 0);
    signal LSB_uid484_rReal_uid16_fpComplexMulTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal rndBitCond_uid485_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (4 downto 0);
    signal cRBit_uid486_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (4 downto 0);
    signal rBi_uid487_rReal_uid16_fpComplexMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal rBi_uid487_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal roundBit_uid488_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracPostNormRndRange_uid489_rReal_uid16_fpComplexMulTest_in : STD_LOGIC_VECTOR (25 downto 0);
    signal fracPostNormRndRange_uid489_rReal_uid16_fpComplexMulTest_b : STD_LOGIC_VECTOR (23 downto 0);
    signal expFracR_uid490_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (33 downto 0);
    signal rndExpFrac_uid491_rReal_uid16_fpComplexMulTest_a : STD_LOGIC_VECTOR (34 downto 0);
    signal rndExpFrac_uid491_rReal_uid16_fpComplexMulTest_b : STD_LOGIC_VECTOR (34 downto 0);
    signal rndExpFrac_uid491_rReal_uid16_fpComplexMulTest_o : STD_LOGIC_VECTOR (34 downto 0);
    signal rndExpFrac_uid491_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (34 downto 0);
    signal wEP2AllOwE_uid492_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (9 downto 0);
    signal rndExp_uid493_rReal_uid16_fpComplexMulTest_in : STD_LOGIC_VECTOR (33 downto 0);
    signal rndExp_uid493_rReal_uid16_fpComplexMulTest_b : STD_LOGIC_VECTOR (9 downto 0);
    signal rOvfEQMax_uid494_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal rndExpFracOvfBits_uid496_rReal_uid16_fpComplexMulTest_in : STD_LOGIC_VECTOR (33 downto 0);
    signal rndExpFracOvfBits_uid496_rReal_uid16_fpComplexMulTest_b : STD_LOGIC_VECTOR (1 downto 0);
    signal rOvfExtraBits_uid497_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal rOvf_uid498_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal wEP2AllZ_uid499_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (9 downto 0);
    signal rUdfEQMin_uid500_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal rUdfExtraBit_uid501_rReal_uid16_fpComplexMulTest_in : STD_LOGIC_VECTOR (33 downto 0);
    signal rUdfExtraBit_uid501_rReal_uid16_fpComplexMulTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal rUdf_uid502_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracRPreExc_uid503_rReal_uid16_fpComplexMulTest_in : STD_LOGIC_VECTOR (23 downto 0);
    signal fracRPreExc_uid503_rReal_uid16_fpComplexMulTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal expRPreExc_uid504_rReal_uid16_fpComplexMulTest_in : STD_LOGIC_VECTOR (31 downto 0);
    signal expRPreExc_uid504_rReal_uid16_fpComplexMulTest_b : STD_LOGIC_VECTOR (7 downto 0);
    signal regInputs_uid505_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excRZeroVInC_uid506_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (4 downto 0);
    signal excRZero_uid507_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal aRegBZeroFPLib_uid508_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal aZeroBRegFPLib_uid509_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fpLibRegInputs_uid510_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal rInfOvf_uid511_rReal_uid16_fpComplexMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal rInfOvf_uid511_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excRInfVInC_uid512_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (5 downto 0);
    signal excRInf_uid513_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excRNaN2_uid514_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excAIBISub_uid515_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excRNaN_uid516_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal concExc_uid517_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (2 downto 0);
    signal excREnc_uid518_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (1 downto 0);
    signal invAMinusA_uid519_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal signRReg_uid520_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal sigBBInf_uid521_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal sigAAInf_uid522_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal signRInf_uid523_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excAZBZSigASigB_uid524_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excBZARSigA_uid525_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal signRZero_uid526_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal signRInfRZRReg_uid527_rReal_uid16_fpComplexMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal signRInfRZRReg_uid527_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal invExcRNaN_uid528_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal signRPostExc_uid529_rReal_uid16_fpComplexMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal signRPostExc_uid529_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal oneFracRPostExc2_uid530_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (22 downto 0);
    signal fracRPostExc_uid533_rReal_uid16_fpComplexMulTest_s : STD_LOGIC_VECTOR (1 downto 0);
    signal fracRPostExc_uid533_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (22 downto 0);
    signal expRPostExc_uid537_rReal_uid16_fpComplexMulTest_s : STD_LOGIC_VECTOR (1 downto 0);
    signal expRPostExc_uid537_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal R_uid538_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (31 downto 0);
    signal excX_uid545_rImag_uid17_fpComplexMulTest_b : STD_LOGIC_VECTOR (1 downto 0);
    signal excXZero_uid550_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excXReg_uid551_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excXInf_uid552_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excXNaN_uid553_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excX_uid559_rImag_uid17_fpComplexMulTest_b : STD_LOGIC_VECTOR (1 downto 0);
    signal excXZero_uid564_rImag_uid17_fpComplexMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excXZero_uid564_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excXReg_uid565_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excXInf_uid566_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excXNaN_uid567_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expFracX_uid568_rImag_uid17_fpComplexMulTest_b : STD_LOGIC_VECTOR (30 downto 0);
    signal expFracY_uid569_rImag_uid17_fpComplexMulTest_b : STD_LOGIC_VECTOR (30 downto 0);
    signal xGTEy_uid570_rImag_uid17_fpComplexMulTest_a : STD_LOGIC_VECTOR (32 downto 0);
    signal xGTEy_uid570_rImag_uid17_fpComplexMulTest_b : STD_LOGIC_VECTOR (32 downto 0);
    signal xGTEy_uid570_rImag_uid17_fpComplexMulTest_o : STD_LOGIC_VECTOR (32 downto 0);
    signal xGTEy_uid570_rImag_uid17_fpComplexMulTest_n : STD_LOGIC_VECTOR (0 downto 0);
    signal xGTEyOrYz_uid571_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal invExcXZ_uid572_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal xGTEy_uid573_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracY_uid574_rImag_uid17_fpComplexMulTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal expY_uid575_rImag_uid17_fpComplexMulTest_b : STD_LOGIC_VECTOR (7 downto 0);
    signal sigY_uid576_rImag_uid17_fpComplexMulTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal ypn_uid577_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (31 downto 0);
    signal xMuxRange_uid579_rImag_uid17_fpComplexMulTest_in : STD_LOGIC_VECTOR (31 downto 0);
    signal xMuxRange_uid579_rImag_uid17_fpComplexMulTest_b : STD_LOGIC_VECTOR (31 downto 0);
    signal aSig_uid581_rImag_uid17_fpComplexMulTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aSig_uid581_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (31 downto 0);
    signal bSig_uid582_rImag_uid17_fpComplexMulTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal bSig_uid582_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (31 downto 0);
    signal excAI_uid583_rImag_uid17_fpComplexMulTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal excAI_uid583_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excAN_uid584_rImag_uid17_fpComplexMulTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal excAN_uid584_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excAR_uid585_rImag_uid17_fpComplexMulTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal excAR_uid585_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excAZ_uid586_rImag_uid17_fpComplexMulTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal excAZ_uid586_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excBI_uid587_rImag_uid17_fpComplexMulTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal excBI_uid587_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excBN_uid588_rImag_uid17_fpComplexMulTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal excBN_uid588_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excBR_uid589_rImag_uid17_fpComplexMulTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal excBR_uid589_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excBZ_uid590_rImag_uid17_fpComplexMulTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal excBZ_uid590_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expA_uid591_rImag_uid17_fpComplexMulTest_in : STD_LOGIC_VECTOR (30 downto 0);
    signal expA_uid591_rImag_uid17_fpComplexMulTest_b : STD_LOGIC_VECTOR (7 downto 0);
    signal expB_uid592_rImag_uid17_fpComplexMulTest_in : STD_LOGIC_VECTOR (30 downto 0);
    signal expB_uid592_rImag_uid17_fpComplexMulTest_b : STD_LOGIC_VECTOR (7 downto 0);
    signal fracA_uid593_rImag_uid17_fpComplexMulTest_in : STD_LOGIC_VECTOR (22 downto 0);
    signal fracA_uid593_rImag_uid17_fpComplexMulTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal fracB_uid594_rImag_uid17_fpComplexMulTest_in : STD_LOGIC_VECTOR (22 downto 0);
    signal fracB_uid594_rImag_uid17_fpComplexMulTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal sigA_uid595_rImag_uid17_fpComplexMulTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal sigB_uid596_rImag_uid17_fpComplexMulTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal effSub_uid597_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracBz_uid603_rImag_uid17_fpComplexMulTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fracBz_uid603_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (22 downto 0);
    signal invExcBZ_uid605_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal oFracB_uid606_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (23 downto 0);
    signal expAmExpB_uid607_rImag_uid17_fpComplexMulTest_a : STD_LOGIC_VECTOR (8 downto 0);
    signal expAmExpB_uid607_rImag_uid17_fpComplexMulTest_b : STD_LOGIC_VECTOR (8 downto 0);
    signal expAmExpB_uid607_rImag_uid17_fpComplexMulTest_i : STD_LOGIC_VECTOR (8 downto 0);
    signal expAmExpB_uid607_rImag_uid17_fpComplexMulTest_o : STD_LOGIC_VECTOR (8 downto 0);
    signal expAmExpB_uid607_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (8 downto 0);
    signal shiftedOut_uid610_rImag_uid17_fpComplexMulTest_a : STD_LOGIC_VECTOR (10 downto 0);
    signal shiftedOut_uid610_rImag_uid17_fpComplexMulTest_b : STD_LOGIC_VECTOR (10 downto 0);
    signal shiftedOut_uid610_rImag_uid17_fpComplexMulTest_o : STD_LOGIC_VECTOR (10 downto 0);
    signal shiftedOut_uid610_rImag_uid17_fpComplexMulTest_c : STD_LOGIC_VECTOR (0 downto 0);
    signal rightPaddedIn_uid612_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (48 downto 0);
    signal iShiftedOut_uid614_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal alignFracBPostShiftOut_uid615_rImag_uid17_fpComplexMulTest_b : STD_LOGIC_VECTOR (48 downto 0);
    signal alignFracBPostShiftOut_uid615_rImag_uid17_fpComplexMulTest_qi : STD_LOGIC_VECTOR (48 downto 0);
    signal alignFracBPostShiftOut_uid615_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (48 downto 0);
    signal cmpEQ_stickyBits_cZwF_uid618_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal invCmpEQ_stickyBits_cZwF_uid619_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal effSubInvSticky_uid621_rImag_uid17_fpComplexMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal effSubInvSticky_uid621_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracAAddOp_uid624_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (26 downto 0);
    signal fracBAddOp_uid627_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (26 downto 0);
    signal fracBAddOpPostXor_uid628_rImag_uid17_fpComplexMulTest_b : STD_LOGIC_VECTOR (26 downto 0);
    signal fracBAddOpPostXor_uid628_rImag_uid17_fpComplexMulTest_qi : STD_LOGIC_VECTOR (26 downto 0);
    signal fracBAddOpPostXor_uid628_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (26 downto 0);
    signal fracAddResult_uid629_rImag_uid17_fpComplexMulTest_a : STD_LOGIC_VECTOR (27 downto 0);
    signal fracAddResult_uid629_rImag_uid17_fpComplexMulTest_b : STD_LOGIC_VECTOR (27 downto 0);
    signal fracAddResult_uid629_rImag_uid17_fpComplexMulTest_o : STD_LOGIC_VECTOR (27 downto 0);
    signal fracAddResult_uid629_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (27 downto 0);
    signal rangeFracAddResultMwfp3Dto0_uid630_rImag_uid17_fpComplexMulTest_in : STD_LOGIC_VECTOR (26 downto 0);
    signal rangeFracAddResultMwfp3Dto0_uid630_rImag_uid17_fpComplexMulTest_b : STD_LOGIC_VECTOR (26 downto 0);
    signal fracGRS_uid631_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (27 downto 0);
    signal aMinusA_uid634_rImag_uid17_fpComplexMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal aMinusA_uid634_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracPostNorm_uid636_rImag_uid17_fpComplexMulTest_b : STD_LOGIC_VECTOR (26 downto 0);
    signal expInc_uid638_rImag_uid17_fpComplexMulTest_a : STD_LOGIC_VECTOR (8 downto 0);
    signal expInc_uid638_rImag_uid17_fpComplexMulTest_b : STD_LOGIC_VECTOR (8 downto 0);
    signal expInc_uid638_rImag_uid17_fpComplexMulTest_o : STD_LOGIC_VECTOR (8 downto 0);
    signal expInc_uid638_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (8 downto 0);
    signal expPostNorm_uid639_rImag_uid17_fpComplexMulTest_a : STD_LOGIC_VECTOR (9 downto 0);
    signal expPostNorm_uid639_rImag_uid17_fpComplexMulTest_b : STD_LOGIC_VECTOR (9 downto 0);
    signal expPostNorm_uid639_rImag_uid17_fpComplexMulTest_o : STD_LOGIC_VECTOR (9 downto 0);
    signal expPostNorm_uid639_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (9 downto 0);
    signal Sticky0_uid640_rImag_uid17_fpComplexMulTest_in : STD_LOGIC_VECTOR (0 downto 0);
    signal Sticky0_uid640_rImag_uid17_fpComplexMulTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal Sticky1_uid641_rImag_uid17_fpComplexMulTest_in : STD_LOGIC_VECTOR (1 downto 0);
    signal Sticky1_uid641_rImag_uid17_fpComplexMulTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal Round_uid642_rImag_uid17_fpComplexMulTest_in : STD_LOGIC_VECTOR (2 downto 0);
    signal Round_uid642_rImag_uid17_fpComplexMulTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal Guard_uid643_rImag_uid17_fpComplexMulTest_in : STD_LOGIC_VECTOR (3 downto 0);
    signal Guard_uid643_rImag_uid17_fpComplexMulTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal LSB_uid644_rImag_uid17_fpComplexMulTest_in : STD_LOGIC_VECTOR (4 downto 0);
    signal LSB_uid644_rImag_uid17_fpComplexMulTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal rndBitCond_uid645_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (4 downto 0);
    signal rBi_uid647_rImag_uid17_fpComplexMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal rBi_uid647_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal roundBit_uid648_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracPostNormRndRange_uid649_rImag_uid17_fpComplexMulTest_in : STD_LOGIC_VECTOR (25 downto 0);
    signal fracPostNormRndRange_uid649_rImag_uid17_fpComplexMulTest_b : STD_LOGIC_VECTOR (23 downto 0);
    signal expFracR_uid650_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (33 downto 0);
    signal rndExpFrac_uid651_rImag_uid17_fpComplexMulTest_a : STD_LOGIC_VECTOR (34 downto 0);
    signal rndExpFrac_uid651_rImag_uid17_fpComplexMulTest_b : STD_LOGIC_VECTOR (34 downto 0);
    signal rndExpFrac_uid651_rImag_uid17_fpComplexMulTest_o : STD_LOGIC_VECTOR (34 downto 0);
    signal rndExpFrac_uid651_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (34 downto 0);
    signal rndExp_uid653_rImag_uid17_fpComplexMulTest_in : STD_LOGIC_VECTOR (33 downto 0);
    signal rndExp_uid653_rImag_uid17_fpComplexMulTest_b : STD_LOGIC_VECTOR (9 downto 0);
    signal rOvfEQMax_uid654_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal rndExpFracOvfBits_uid656_rImag_uid17_fpComplexMulTest_in : STD_LOGIC_VECTOR (33 downto 0);
    signal rndExpFracOvfBits_uid656_rImag_uid17_fpComplexMulTest_b : STD_LOGIC_VECTOR (1 downto 0);
    signal rOvfExtraBits_uid657_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal rOvf_uid658_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal rUdfEQMin_uid660_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal rUdfExtraBit_uid661_rImag_uid17_fpComplexMulTest_in : STD_LOGIC_VECTOR (33 downto 0);
    signal rUdfExtraBit_uid661_rImag_uid17_fpComplexMulTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal rUdf_uid662_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracRPreExc_uid663_rImag_uid17_fpComplexMulTest_in : STD_LOGIC_VECTOR (23 downto 0);
    signal fracRPreExc_uid663_rImag_uid17_fpComplexMulTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal expRPreExc_uid664_rImag_uid17_fpComplexMulTest_in : STD_LOGIC_VECTOR (31 downto 0);
    signal expRPreExc_uid664_rImag_uid17_fpComplexMulTest_b : STD_LOGIC_VECTOR (7 downto 0);
    signal regInputs_uid665_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excRZeroVInC_uid666_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (4 downto 0);
    signal excRZero_uid667_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal aRegBZeroFPLib_uid668_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal aZeroBRegFPLib_uid669_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fpLibRegInputs_uid670_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal rInfOvf_uid671_rImag_uid17_fpComplexMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal rInfOvf_uid671_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excRInfVInC_uid672_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (5 downto 0);
    signal excRInf_uid673_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excRNaN2_uid674_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excAIBISub_uid675_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excRNaN_uid676_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal concExc_uid677_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (2 downto 0);
    signal excREnc_uid678_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (1 downto 0);
    signal invAMinusA_uid679_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal signRReg_uid680_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal sigBBInf_uid681_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal sigAAInf_uid682_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal signRInf_uid683_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excAZBZSigASigB_uid684_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excBZARSigA_uid685_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal signRZero_uid686_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal signRInfRZRReg_uid687_rImag_uid17_fpComplexMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal signRInfRZRReg_uid687_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal invExcRNaN_uid688_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal signRPostExc_uid689_rImag_uid17_fpComplexMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal signRPostExc_uid689_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracRPostExc_uid693_rImag_uid17_fpComplexMulTest_s : STD_LOGIC_VECTOR (1 downto 0);
    signal fracRPostExc_uid693_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (22 downto 0);
    signal expRPostExc_uid697_rImag_uid17_fpComplexMulTest_s : STD_LOGIC_VECTOR (1 downto 0);
    signal expRPostExc_uid697_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal R_uid698_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (31 downto 0);
    signal osig_uid701_prod_uid61_ac_uid6_fpComplexMulTest_in : STD_LOGIC_VECTOR (47 downto 0);
    signal osig_uid701_prod_uid61_ac_uid6_fpComplexMulTest_b : STD_LOGIC_VECTOR (47 downto 0);
    signal osig_uid704_prod_uid151_bd_uid7_fpComplexMulTest_in : STD_LOGIC_VECTOR (47 downto 0);
    signal osig_uid704_prod_uid151_bd_uid7_fpComplexMulTest_b : STD_LOGIC_VECTOR (47 downto 0);
    signal osig_uid707_prod_uid241_ad_uid8_fpComplexMulTest_in : STD_LOGIC_VECTOR (47 downto 0);
    signal osig_uid707_prod_uid241_ad_uid8_fpComplexMulTest_b : STD_LOGIC_VECTOR (47 downto 0);
    signal osig_uid710_prod_uid331_bc_uid9_fpComplexMulTest_in : STD_LOGIC_VECTOR (47 downto 0);
    signal osig_uid710_prod_uid331_bc_uid9_fpComplexMulTest_b : STD_LOGIC_VECTOR (47 downto 0);
    signal zs_uid712_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (15 downto 0);
    signal rVStage_uid713_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_b : STD_LOGIC_VECTOR (15 downto 0);
    signal vCount_uid714_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal vCount_uid714_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal mO_uid715_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (3 downto 0);
    signal vStage_uid716_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_in : STD_LOGIC_VECTOR (11 downto 0);
    signal vStage_uid716_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_b : STD_LOGIC_VECTOR (11 downto 0);
    signal cStage_uid717_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (15 downto 0);
    signal vStagei_uid719_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid719_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (15 downto 0);
    signal vCount_uid722_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid725_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid725_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal zs_uid726_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (3 downto 0);
    signal vCount_uid728_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal vCount_uid728_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid731_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid731_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (3 downto 0);
    signal vCount_uid734_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid737_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid737_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (1 downto 0);
    signal rVStage_uid739_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal vCount_uid740_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal r_uid741_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (4 downto 0);
    signal rVStage_uid744_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_b : STD_LOGIC_VECTOR (15 downto 0);
    signal vCount_uid745_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal vCount_uid745_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStage_uid747_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_in : STD_LOGIC_VECTOR (11 downto 0);
    signal vStage_uid747_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_b : STD_LOGIC_VECTOR (11 downto 0);
    signal cStage_uid748_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (15 downto 0);
    signal vStagei_uid750_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid750_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (15 downto 0);
    signal vCount_uid753_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid756_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid756_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal vCount_uid759_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal vCount_uid759_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid762_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid762_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (3 downto 0);
    signal vCount_uid765_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid768_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid768_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (1 downto 0);
    signal rVStage_uid770_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal vCount_uid771_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal r_uid772_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (4 downto 0);
    signal expUdf_uid87_ac_uid6_fpComplexMulTest_cmp_sign_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expUdf_uid177_bd_uid7_fpComplexMulTest_cmp_sign_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expUdf_uid267_ad_uid8_fpComplexMulTest_cmp_sign_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expUdf_uid357_bc_uid9_fpComplexMulTest_cmp_sign_q : STD_LOGIC_VECTOR (0 downto 0);
    signal wIntCst_uid784_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (5 downto 0);
    signal shiftedOut_uid785_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_a : STD_LOGIC_VECTOR (10 downto 0);
    signal shiftedOut_uid785_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_b : STD_LOGIC_VECTOR (10 downto 0);
    signal shiftedOut_uid785_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_o : STD_LOGIC_VECTOR (10 downto 0);
    signal shiftedOut_uid785_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_n : STD_LOGIC_VECTOR (0 downto 0);
    signal rightShiftStage0Idx1Rng8_uid786_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_b : STD_LOGIC_VECTOR (40 downto 0);
    signal rightShiftStage0Idx1_uid788_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage0Idx2Rng16_uid789_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_b : STD_LOGIC_VECTOR (32 downto 0);
    signal rightShiftStage0Idx2_uid791_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage0Idx3Rng24_uid792_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_b : STD_LOGIC_VECTOR (24 downto 0);
    signal rightShiftStage0Idx3Pad24_uid793_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (23 downto 0);
    signal rightShiftStage0Idx3_uid794_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage0Idx4Rng32_uid795_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_b : STD_LOGIC_VECTOR (16 downto 0);
    signal rightShiftStage0Idx4Pad32_uid796_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (31 downto 0);
    signal rightShiftStage0Idx4_uid797_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage0Idx5Rng40_uid798_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_b : STD_LOGIC_VECTOR (8 downto 0);
    signal rightShiftStage0Idx5Pad40_uid799_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (39 downto 0);
    signal rightShiftStage0Idx5_uid800_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage0Idx6Rng48_uid801_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal rightShiftStage0Idx6Pad48_uid802_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (47 downto 0);
    signal rightShiftStage0Idx6_uid803_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage0Idx7_uid804_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage1Idx1Rng1_uid807_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_b : STD_LOGIC_VECTOR (47 downto 0);
    signal rightShiftStage1Idx1_uid809_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage1Idx2Rng2_uid810_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_b : STD_LOGIC_VECTOR (46 downto 0);
    signal rightShiftStage1Idx2_uid812_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage1Idx3Rng3_uid813_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_b : STD_LOGIC_VECTOR (45 downto 0);
    signal rightShiftStage1Idx3Pad3_uid814_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (2 downto 0);
    signal rightShiftStage1Idx3_uid815_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage1Idx4Rng4_uid816_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_b : STD_LOGIC_VECTOR (44 downto 0);
    signal rightShiftStage1Idx4_uid818_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage1Idx5Rng5_uid819_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_b : STD_LOGIC_VECTOR (43 downto 0);
    signal rightShiftStage1Idx5Pad5_uid820_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (4 downto 0);
    signal rightShiftStage1Idx5_uid821_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage1Idx6Rng6_uid822_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_b : STD_LOGIC_VECTOR (42 downto 0);
    signal rightShiftStage1Idx6Pad6_uid823_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (5 downto 0);
    signal rightShiftStage1Idx6_uid824_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage1Idx7Rng7_uid825_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_b : STD_LOGIC_VECTOR (41 downto 0);
    signal rightShiftStage1Idx7Pad7_uid826_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (6 downto 0);
    signal rightShiftStage1Idx7_uid827_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (48 downto 0);
    signal r_uid831_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal r_uid831_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (48 downto 0);
    signal leftShiftStage0Idx1Rng4_uid836_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_in : STD_LOGIC_VECTOR (23 downto 0);
    signal leftShiftStage0Idx1Rng4_uid836_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_b : STD_LOGIC_VECTOR (23 downto 0);
    signal leftShiftStage0Idx1_uid837_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (27 downto 0);
    signal leftShiftStage0Idx2Rng8_uid839_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_in : STD_LOGIC_VECTOR (19 downto 0);
    signal leftShiftStage0Idx2Rng8_uid839_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_b : STD_LOGIC_VECTOR (19 downto 0);
    signal leftShiftStage0Idx2_uid840_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (27 downto 0);
    signal leftShiftStage0Idx3Pad12_uid841_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (11 downto 0);
    signal leftShiftStage0Idx3Rng12_uid842_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_in : STD_LOGIC_VECTOR (15 downto 0);
    signal leftShiftStage0Idx3Rng12_uid842_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_b : STD_LOGIC_VECTOR (15 downto 0);
    signal leftShiftStage0Idx3_uid843_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (27 downto 0);
    signal leftShiftStage0Idx4_uid846_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (27 downto 0);
    signal leftShiftStage0Idx5Pad20_uid847_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (19 downto 0);
    signal leftShiftStage0Idx5Rng20_uid848_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_in : STD_LOGIC_VECTOR (7 downto 0);
    signal leftShiftStage0Idx5Rng20_uid848_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_b : STD_LOGIC_VECTOR (7 downto 0);
    signal leftShiftStage0Idx5_uid849_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (27 downto 0);
    signal leftShiftStage0Idx6Rng24_uid851_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_in : STD_LOGIC_VECTOR (3 downto 0);
    signal leftShiftStage0Idx6Rng24_uid851_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_b : STD_LOGIC_VECTOR (3 downto 0);
    signal leftShiftStage0Idx6_uid852_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (27 downto 0);
    signal leftShiftStage0Idx7_uid853_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (27 downto 0);
    signal leftShiftStage1Idx1Rng1_uid857_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_in : STD_LOGIC_VECTOR (26 downto 0);
    signal leftShiftStage1Idx1Rng1_uid857_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_b : STD_LOGIC_VECTOR (26 downto 0);
    signal leftShiftStage1Idx1_uid858_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (27 downto 0);
    signal leftShiftStage1Idx2Rng2_uid860_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_in : STD_LOGIC_VECTOR (25 downto 0);
    signal leftShiftStage1Idx2Rng2_uid860_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_b : STD_LOGIC_VECTOR (25 downto 0);
    signal leftShiftStage1Idx2_uid861_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (27 downto 0);
    signal leftShiftStage1Idx3Rng3_uid863_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_in : STD_LOGIC_VECTOR (24 downto 0);
    signal leftShiftStage1Idx3Rng3_uid863_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_b : STD_LOGIC_VECTOR (24 downto 0);
    signal leftShiftStage1Idx3_uid864_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (27 downto 0);
    signal leftShiftStage1_uid866_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_s : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStage1_uid866_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_q : STD_LOGIC_VECTOR (27 downto 0);
    signal shiftedOut_uid871_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_a : STD_LOGIC_VECTOR (10 downto 0);
    signal shiftedOut_uid871_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_b : STD_LOGIC_VECTOR (10 downto 0);
    signal shiftedOut_uid871_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_o : STD_LOGIC_VECTOR (10 downto 0);
    signal shiftedOut_uid871_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_n : STD_LOGIC_VECTOR (0 downto 0);
    signal rightShiftStage0Idx1Rng8_uid872_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_b : STD_LOGIC_VECTOR (40 downto 0);
    signal rightShiftStage0Idx1_uid874_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage0Idx2Rng16_uid875_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_b : STD_LOGIC_VECTOR (32 downto 0);
    signal rightShiftStage0Idx2_uid877_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage0Idx3Rng24_uid878_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_b : STD_LOGIC_VECTOR (24 downto 0);
    signal rightShiftStage0Idx3_uid880_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage0Idx4Rng32_uid881_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_b : STD_LOGIC_VECTOR (16 downto 0);
    signal rightShiftStage0Idx4_uid883_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage0Idx5Rng40_uid884_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_b : STD_LOGIC_VECTOR (8 downto 0);
    signal rightShiftStage0Idx5_uid886_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage0Idx6Rng48_uid887_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal rightShiftStage0Idx6_uid889_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage1Idx1Rng1_uid893_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_b : STD_LOGIC_VECTOR (47 downto 0);
    signal rightShiftStage1Idx1_uid895_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage1Idx2Rng2_uid896_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_b : STD_LOGIC_VECTOR (46 downto 0);
    signal rightShiftStage1Idx2_uid898_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage1Idx3Rng3_uid899_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_b : STD_LOGIC_VECTOR (45 downto 0);
    signal rightShiftStage1Idx3_uid901_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage1Idx4Rng4_uid902_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_b : STD_LOGIC_VECTOR (44 downto 0);
    signal rightShiftStage1Idx4_uid904_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage1Idx5Rng5_uid905_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_b : STD_LOGIC_VECTOR (43 downto 0);
    signal rightShiftStage1Idx5_uid907_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage1Idx6Rng6_uid908_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_b : STD_LOGIC_VECTOR (42 downto 0);
    signal rightShiftStage1Idx6_uid910_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage1Idx7Rng7_uid911_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_b : STD_LOGIC_VECTOR (41 downto 0);
    signal rightShiftStage1Idx7_uid913_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (48 downto 0);
    signal r_uid917_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal r_uid917_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (48 downto 0);
    signal leftShiftStage0Idx1Rng4_uid922_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_in : STD_LOGIC_VECTOR (23 downto 0);
    signal leftShiftStage0Idx1Rng4_uid922_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_b : STD_LOGIC_VECTOR (23 downto 0);
    signal leftShiftStage0Idx1_uid923_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (27 downto 0);
    signal leftShiftStage0Idx2Rng8_uid925_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_in : STD_LOGIC_VECTOR (19 downto 0);
    signal leftShiftStage0Idx2Rng8_uid925_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_b : STD_LOGIC_VECTOR (19 downto 0);
    signal leftShiftStage0Idx2_uid926_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (27 downto 0);
    signal leftShiftStage0Idx3Rng12_uid928_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_in : STD_LOGIC_VECTOR (15 downto 0);
    signal leftShiftStage0Idx3Rng12_uid928_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_b : STD_LOGIC_VECTOR (15 downto 0);
    signal leftShiftStage0Idx3_uid929_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (27 downto 0);
    signal leftShiftStage0Idx4_uid932_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (27 downto 0);
    signal leftShiftStage0Idx5Rng20_uid934_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_in : STD_LOGIC_VECTOR (7 downto 0);
    signal leftShiftStage0Idx5Rng20_uid934_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_b : STD_LOGIC_VECTOR (7 downto 0);
    signal leftShiftStage0Idx5_uid935_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (27 downto 0);
    signal leftShiftStage0Idx6Rng24_uid937_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_in : STD_LOGIC_VECTOR (3 downto 0);
    signal leftShiftStage0Idx6Rng24_uid937_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_b : STD_LOGIC_VECTOR (3 downto 0);
    signal leftShiftStage0Idx6_uid938_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (27 downto 0);
    signal leftShiftStage1Idx1Rng1_uid943_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_in : STD_LOGIC_VECTOR (26 downto 0);
    signal leftShiftStage1Idx1Rng1_uid943_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_b : STD_LOGIC_VECTOR (26 downto 0);
    signal leftShiftStage1Idx1_uid944_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (27 downto 0);
    signal leftShiftStage1Idx2Rng2_uid946_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_in : STD_LOGIC_VECTOR (25 downto 0);
    signal leftShiftStage1Idx2Rng2_uid946_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_b : STD_LOGIC_VECTOR (25 downto 0);
    signal leftShiftStage1Idx2_uid947_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (27 downto 0);
    signal leftShiftStage1Idx3Rng3_uid949_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_in : STD_LOGIC_VECTOR (24 downto 0);
    signal leftShiftStage1Idx3Rng3_uid949_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_b : STD_LOGIC_VECTOR (24 downto 0);
    signal leftShiftStage1Idx3_uid950_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (27 downto 0);
    signal leftShiftStage1_uid952_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_s : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStage1_uid952_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_q : STD_LOGIC_VECTOR (27 downto 0);
    signal prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im0_a0 : STD_LOGIC_VECTOR (17 downto 0);
    signal prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im0_b0 : STD_LOGIC_VECTOR (17 downto 0);
    signal prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im0_s1 : STD_LOGIC_VECTOR (35 downto 0);
    signal prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im0_reset : std_logic;
    signal prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im0_q : STD_LOGIC_VECTOR (35 downto 0);
    signal prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im3_a0 : STD_LOGIC_VECTOR (17 downto 0);
    signal prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im3_b0 : STD_LOGIC_VECTOR (5 downto 0);
    signal prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im3_s1 : STD_LOGIC_VECTOR (23 downto 0);
    signal prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im3_reset : std_logic;
    signal prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im3_q : STD_LOGIC_VECTOR (23 downto 0);
    signal prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im6_a0 : STD_LOGIC_VECTOR (17 downto 0);
    signal prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im6_b0 : STD_LOGIC_VECTOR (5 downto 0);
    signal prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im6_s1 : STD_LOGIC_VECTOR (23 downto 0);
    signal prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im6_reset : std_logic;
    signal prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im6_q : STD_LOGIC_VECTOR (23 downto 0);
    signal prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im9_a0 : STD_LOGIC_VECTOR (5 downto 0);
    signal prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im9_b0 : STD_LOGIC_VECTOR (5 downto 0);
    signal prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im9_s1 : STD_LOGIC_VECTOR (11 downto 0);
    signal prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im9_reset : std_logic;
    signal prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im9_q : STD_LOGIC_VECTOR (11 downto 0);
    signal prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_join_12_q : STD_LOGIC_VECTOR (47 downto 0);
    signal prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_align_13_q : STD_LOGIC_VECTOR (41 downto 0);
    signal prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_align_13_qint : STD_LOGIC_VECTOR (41 downto 0);
    signal prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_align_15_q : STD_LOGIC_VECTOR (41 downto 0);
    signal prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_align_15_qint : STD_LOGIC_VECTOR (41 downto 0);
    signal prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_result_add_0_0_a : STD_LOGIC_VECTOR (48 downto 0);
    signal prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_result_add_0_0_b : STD_LOGIC_VECTOR (48 downto 0);
    signal prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_result_add_0_0_o : STD_LOGIC_VECTOR (48 downto 0);
    signal prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_result_add_0_0_q : STD_LOGIC_VECTOR (48 downto 0);
    signal prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_result_add_1_0_a : STD_LOGIC_VECTOR (49 downto 0);
    signal prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_result_add_1_0_b : STD_LOGIC_VECTOR (49 downto 0);
    signal prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_result_add_1_0_o : STD_LOGIC_VECTOR (49 downto 0);
    signal prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_result_add_1_0_q : STD_LOGIC_VECTOR (49 downto 0);
    signal prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im0_a0 : STD_LOGIC_VECTOR (17 downto 0);
    signal prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im0_b0 : STD_LOGIC_VECTOR (17 downto 0);
    signal prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im0_s1 : STD_LOGIC_VECTOR (35 downto 0);
    signal prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im0_reset : std_logic;
    signal prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im0_q : STD_LOGIC_VECTOR (35 downto 0);
    signal prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im3_a0 : STD_LOGIC_VECTOR (17 downto 0);
    signal prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im3_b0 : STD_LOGIC_VECTOR (5 downto 0);
    signal prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im3_s1 : STD_LOGIC_VECTOR (23 downto 0);
    signal prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im3_reset : std_logic;
    signal prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im3_q : STD_LOGIC_VECTOR (23 downto 0);
    signal prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im6_a0 : STD_LOGIC_VECTOR (17 downto 0);
    signal prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im6_b0 : STD_LOGIC_VECTOR (5 downto 0);
    signal prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im6_s1 : STD_LOGIC_VECTOR (23 downto 0);
    signal prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im6_reset : std_logic;
    signal prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im6_q : STD_LOGIC_VECTOR (23 downto 0);
    signal prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im9_a0 : STD_LOGIC_VECTOR (5 downto 0);
    signal prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im9_b0 : STD_LOGIC_VECTOR (5 downto 0);
    signal prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im9_s1 : STD_LOGIC_VECTOR (11 downto 0);
    signal prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im9_reset : std_logic;
    signal prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im9_q : STD_LOGIC_VECTOR (11 downto 0);
    signal prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_join_12_q : STD_LOGIC_VECTOR (47 downto 0);
    signal prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_align_13_q : STD_LOGIC_VECTOR (41 downto 0);
    signal prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_align_13_qint : STD_LOGIC_VECTOR (41 downto 0);
    signal prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_align_15_q : STD_LOGIC_VECTOR (41 downto 0);
    signal prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_align_15_qint : STD_LOGIC_VECTOR (41 downto 0);
    signal prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_result_add_0_0_a : STD_LOGIC_VECTOR (48 downto 0);
    signal prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_result_add_0_0_b : STD_LOGIC_VECTOR (48 downto 0);
    signal prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_result_add_0_0_o : STD_LOGIC_VECTOR (48 downto 0);
    signal prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_result_add_0_0_q : STD_LOGIC_VECTOR (48 downto 0);
    signal prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_result_add_1_0_a : STD_LOGIC_VECTOR (49 downto 0);
    signal prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_result_add_1_0_b : STD_LOGIC_VECTOR (49 downto 0);
    signal prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_result_add_1_0_o : STD_LOGIC_VECTOR (49 downto 0);
    signal prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_result_add_1_0_q : STD_LOGIC_VECTOR (49 downto 0);
    signal prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im0_a0 : STD_LOGIC_VECTOR (17 downto 0);
    signal prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im0_b0 : STD_LOGIC_VECTOR (17 downto 0);
    signal prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im0_s1 : STD_LOGIC_VECTOR (35 downto 0);
    signal prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im0_reset : std_logic;
    signal prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im0_q : STD_LOGIC_VECTOR (35 downto 0);
    signal prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im3_a0 : STD_LOGIC_VECTOR (17 downto 0);
    signal prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im3_b0 : STD_LOGIC_VECTOR (5 downto 0);
    signal prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im3_s1 : STD_LOGIC_VECTOR (23 downto 0);
    signal prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im3_reset : std_logic;
    signal prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im3_q : STD_LOGIC_VECTOR (23 downto 0);
    signal prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im6_a0 : STD_LOGIC_VECTOR (17 downto 0);
    signal prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im6_b0 : STD_LOGIC_VECTOR (5 downto 0);
    signal prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im6_s1 : STD_LOGIC_VECTOR (23 downto 0);
    signal prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im6_reset : std_logic;
    signal prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im6_q : STD_LOGIC_VECTOR (23 downto 0);
    signal prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im9_a0 : STD_LOGIC_VECTOR (5 downto 0);
    signal prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im9_b0 : STD_LOGIC_VECTOR (5 downto 0);
    signal prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im9_s1 : STD_LOGIC_VECTOR (11 downto 0);
    signal prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im9_reset : std_logic;
    signal prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im9_q : STD_LOGIC_VECTOR (11 downto 0);
    signal prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_join_12_q : STD_LOGIC_VECTOR (47 downto 0);
    signal prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_align_13_q : STD_LOGIC_VECTOR (41 downto 0);
    signal prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_align_13_qint : STD_LOGIC_VECTOR (41 downto 0);
    signal prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_align_15_q : STD_LOGIC_VECTOR (41 downto 0);
    signal prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_align_15_qint : STD_LOGIC_VECTOR (41 downto 0);
    signal prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_result_add_0_0_a : STD_LOGIC_VECTOR (48 downto 0);
    signal prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_result_add_0_0_b : STD_LOGIC_VECTOR (48 downto 0);
    signal prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_result_add_0_0_o : STD_LOGIC_VECTOR (48 downto 0);
    signal prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_result_add_0_0_q : STD_LOGIC_VECTOR (48 downto 0);
    signal prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_result_add_1_0_a : STD_LOGIC_VECTOR (49 downto 0);
    signal prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_result_add_1_0_b : STD_LOGIC_VECTOR (49 downto 0);
    signal prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_result_add_1_0_o : STD_LOGIC_VECTOR (49 downto 0);
    signal prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_result_add_1_0_q : STD_LOGIC_VECTOR (49 downto 0);
    signal prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im0_a0 : STD_LOGIC_VECTOR (17 downto 0);
    signal prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im0_b0 : STD_LOGIC_VECTOR (17 downto 0);
    signal prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im0_s1 : STD_LOGIC_VECTOR (35 downto 0);
    signal prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im0_reset : std_logic;
    signal prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im0_q : STD_LOGIC_VECTOR (35 downto 0);
    signal prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im3_a0 : STD_LOGIC_VECTOR (17 downto 0);
    signal prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im3_b0 : STD_LOGIC_VECTOR (5 downto 0);
    signal prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im3_s1 : STD_LOGIC_VECTOR (23 downto 0);
    signal prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im3_reset : std_logic;
    signal prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im3_q : STD_LOGIC_VECTOR (23 downto 0);
    signal prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im6_a0 : STD_LOGIC_VECTOR (17 downto 0);
    signal prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im6_b0 : STD_LOGIC_VECTOR (5 downto 0);
    signal prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im6_s1 : STD_LOGIC_VECTOR (23 downto 0);
    signal prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im6_reset : std_logic;
    signal prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im6_q : STD_LOGIC_VECTOR (23 downto 0);
    signal prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im9_a0 : STD_LOGIC_VECTOR (5 downto 0);
    signal prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im9_b0 : STD_LOGIC_VECTOR (5 downto 0);
    signal prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im9_s1 : STD_LOGIC_VECTOR (11 downto 0);
    signal prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im9_reset : std_logic;
    signal prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im9_q : STD_LOGIC_VECTOR (11 downto 0);
    signal prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_join_12_q : STD_LOGIC_VECTOR (47 downto 0);
    signal prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_align_13_q : STD_LOGIC_VECTOR (41 downto 0);
    signal prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_align_13_qint : STD_LOGIC_VECTOR (41 downto 0);
    signal prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_align_15_q : STD_LOGIC_VECTOR (41 downto 0);
    signal prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_align_15_qint : STD_LOGIC_VECTOR (41 downto 0);
    signal prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_result_add_0_0_a : STD_LOGIC_VECTOR (48 downto 0);
    signal prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_result_add_0_0_b : STD_LOGIC_VECTOR (48 downto 0);
    signal prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_result_add_0_0_o : STD_LOGIC_VECTOR (48 downto 0);
    signal prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_result_add_0_0_q : STD_LOGIC_VECTOR (48 downto 0);
    signal prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_result_add_1_0_a : STD_LOGIC_VECTOR (49 downto 0);
    signal prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_result_add_1_0_b : STD_LOGIC_VECTOR (49 downto 0);
    signal prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_result_add_1_0_o : STD_LOGIC_VECTOR (49 downto 0);
    signal prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_result_add_1_0_q : STD_LOGIC_VECTOR (49 downto 0);
    signal rightShiftStage0_uid806_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_msplit_0_s : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage0_uid806_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_msplit_0_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage0_uid806_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_msplit_1_s : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage0_uid806_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_msplit_1_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage0_uid806_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_mfinal_s : STD_LOGIC_VECTOR (0 downto 0);
    signal rightShiftStage0_uid806_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_mfinal_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage1_uid829_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_msplit_0_s : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage1_uid829_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_msplit_0_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage1_uid829_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_msplit_1_s : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage1_uid829_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_msplit_1_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage1_uid829_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_mfinal_s : STD_LOGIC_VECTOR (0 downto 0);
    signal rightShiftStage1_uid829_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_mfinal_q : STD_LOGIC_VECTOR (48 downto 0);
    signal leftShiftStage0_uid855_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_msplit_0_s : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStage0_uid855_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_msplit_0_q : STD_LOGIC_VECTOR (27 downto 0);
    signal leftShiftStage0_uid855_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_msplit_1_s : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStage0_uid855_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_msplit_1_q : STD_LOGIC_VECTOR (27 downto 0);
    signal leftShiftStage0_uid855_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_mfinal_s : STD_LOGIC_VECTOR (0 downto 0);
    signal leftShiftStage0_uid855_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_mfinal_q : STD_LOGIC_VECTOR (27 downto 0);
    signal rightShiftStage0_uid892_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_msplit_0_s : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage0_uid892_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_msplit_0_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage0_uid892_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_msplit_1_s : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage0_uid892_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_msplit_1_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage0_uid892_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_mfinal_s : STD_LOGIC_VECTOR (0 downto 0);
    signal rightShiftStage0_uid892_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_mfinal_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage1_uid915_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_msplit_0_s : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage1_uid915_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_msplit_0_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage1_uid915_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_msplit_1_s : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage1_uid915_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_msplit_1_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage1_uid915_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_mfinal_s : STD_LOGIC_VECTOR (0 downto 0);
    signal rightShiftStage1_uid915_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_mfinal_q : STD_LOGIC_VECTOR (48 downto 0);
    signal leftShiftStage0_uid941_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_msplit_0_s : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStage0_uid941_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_msplit_0_q : STD_LOGIC_VECTOR (27 downto 0);
    signal leftShiftStage0_uid941_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_msplit_1_s : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStage0_uid941_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_msplit_1_q : STD_LOGIC_VECTOR (27 downto 0);
    signal leftShiftStage0_uid941_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_mfinal_s : STD_LOGIC_VECTOR (0 downto 0);
    signal leftShiftStage0_uid941_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_mfinal_q : STD_LOGIC_VECTOR (27 downto 0);
    signal prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_bs1_merged_bit_select_b : STD_LOGIC_VECTOR (17 downto 0);
    signal prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_bs1_merged_bit_select_c : STD_LOGIC_VECTOR (5 downto 0);
    signal prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_bs2_merged_bit_select_b : STD_LOGIC_VECTOR (17 downto 0);
    signal prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_bs2_merged_bit_select_c : STD_LOGIC_VECTOR (5 downto 0);
    signal prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_bs1_merged_bit_select_b : STD_LOGIC_VECTOR (17 downto 0);
    signal prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_bs1_merged_bit_select_c : STD_LOGIC_VECTOR (5 downto 0);
    signal prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_bs2_merged_bit_select_b : STD_LOGIC_VECTOR (17 downto 0);
    signal prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_bs2_merged_bit_select_c : STD_LOGIC_VECTOR (5 downto 0);
    signal rightShiftStageSel5Dto3_uid805_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_merged_bit_select_in : STD_LOGIC_VECTOR (5 downto 0);
    signal rightShiftStageSel5Dto3_uid805_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_merged_bit_select_b : STD_LOGIC_VECTOR (2 downto 0);
    signal rightShiftStageSel5Dto3_uid805_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_merged_bit_select_c : STD_LOGIC_VECTOR (2 downto 0);
    signal stickyBits_uid456_rReal_uid16_fpComplexMulTest_merged_bit_select_b : STD_LOGIC_VECTOR (22 downto 0);
    signal stickyBits_uid456_rReal_uid16_fpComplexMulTest_merged_bit_select_c : STD_LOGIC_VECTOR (25 downto 0);
    signal rightShiftStageSel5Dto3_uid891_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_merged_bit_select_in : STD_LOGIC_VECTOR (5 downto 0);
    signal rightShiftStageSel5Dto3_uid891_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_merged_bit_select_b : STD_LOGIC_VECTOR (2 downto 0);
    signal rightShiftStageSel5Dto3_uid891_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_merged_bit_select_c : STD_LOGIC_VECTOR (2 downto 0);
    signal stickyBits_uid616_rImag_uid17_fpComplexMulTest_merged_bit_select_b : STD_LOGIC_VECTOR (22 downto 0);
    signal stickyBits_uid616_rImag_uid17_fpComplexMulTest_merged_bit_select_c : STD_LOGIC_VECTOR (25 downto 0);
    signal rVStage_uid721_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_merged_bit_select_b : STD_LOGIC_VECTOR (7 downto 0);
    signal rVStage_uid721_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_merged_bit_select_c : STD_LOGIC_VECTOR (7 downto 0);
    signal rVStage_uid727_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_merged_bit_select_b : STD_LOGIC_VECTOR (3 downto 0);
    signal rVStage_uid727_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_merged_bit_select_c : STD_LOGIC_VECTOR (3 downto 0);
    signal rVStage_uid733_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_merged_bit_select_b : STD_LOGIC_VECTOR (1 downto 0);
    signal rVStage_uid733_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_merged_bit_select_c : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStageSel4Dto2_uid854_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_merged_bit_select_b : STD_LOGIC_VECTOR (2 downto 0);
    signal leftShiftStageSel4Dto2_uid854_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_merged_bit_select_c : STD_LOGIC_VECTOR (1 downto 0);
    signal rVStage_uid752_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_merged_bit_select_b : STD_LOGIC_VECTOR (7 downto 0);
    signal rVStage_uid752_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_merged_bit_select_c : STD_LOGIC_VECTOR (7 downto 0);
    signal rVStage_uid758_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_merged_bit_select_b : STD_LOGIC_VECTOR (3 downto 0);
    signal rVStage_uid758_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_merged_bit_select_c : STD_LOGIC_VECTOR (3 downto 0);
    signal rVStage_uid764_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_merged_bit_select_b : STD_LOGIC_VECTOR (1 downto 0);
    signal rVStage_uid764_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_merged_bit_select_c : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStageSel4Dto2_uid940_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_merged_bit_select_b : STD_LOGIC_VECTOR (2 downto 0);
    signal leftShiftStageSel4Dto2_uid940_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_merged_bit_select_c : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage0_uid806_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_selLSBs_merged_bit_select_b : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage0_uid806_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_selLSBs_merged_bit_select_c : STD_LOGIC_VECTOR (0 downto 0);
    signal rightShiftStage1_uid829_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_selLSBs_merged_bit_select_b : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage1_uid829_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_selLSBs_merged_bit_select_c : STD_LOGIC_VECTOR (0 downto 0);
    signal rightShiftStage0_uid892_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_selLSBs_merged_bit_select_b : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage0_uid892_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_selLSBs_merged_bit_select_c : STD_LOGIC_VECTOR (0 downto 0);
    signal rightShiftStage1_uid915_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_selLSBs_merged_bit_select_b : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage1_uid915_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_selLSBs_merged_bit_select_c : STD_LOGIC_VECTOR (0 downto 0);
    signal leftShiftStage0_uid855_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_selLSBs_merged_bit_select_b : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStage0_uid855_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_selLSBs_merged_bit_select_c : STD_LOGIC_VECTOR (0 downto 0);
    signal leftShiftStage0_uid941_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_selLSBs_merged_bit_select_b : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStage0_uid941_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_selLSBs_merged_bit_select_c : STD_LOGIC_VECTOR (0 downto 0);
    signal redist0_leftShiftStage0_uid941_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_selLSBs_merged_bit_select_c_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist1_leftShiftStage0_uid855_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_selLSBs_merged_bit_select_c_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist2_leftShiftStageSel4Dto2_uid940_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_merged_bit_select_c_1_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist3_rVStage_uid758_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_merged_bit_select_b_1_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist4_rVStage_uid758_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_merged_bit_select_c_1_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist5_leftShiftStageSel4Dto2_uid854_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_merged_bit_select_c_1_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist6_rVStage_uid727_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_merged_bit_select_b_1_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist7_rVStage_uid727_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_merged_bit_select_c_1_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist8_rightShiftStageSel5Dto3_uid891_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_merged_bit_select_c_1_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist9_rightShiftStageSel5Dto3_uid805_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_merged_bit_select_c_1_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist10_prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_bs2_merged_bit_select_b_1_q : STD_LOGIC_VECTOR (17 downto 0);
    signal redist11_prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_bs1_merged_bit_select_c_1_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist12_prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_bs2_merged_bit_select_b_1_q : STD_LOGIC_VECTOR (17 downto 0);
    signal redist13_prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_bs1_merged_bit_select_c_1_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist14_vCount_uid753_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_q_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist15_vStage_uid747_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_b_1_q : STD_LOGIC_VECTOR (11 downto 0);
    signal redist16_vCount_uid745_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_q_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist17_rVStage_uid744_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_b_1_q : STD_LOGIC_VECTOR (15 downto 0);
    signal redist18_vCount_uid722_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist19_vStage_uid716_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_b_1_q : STD_LOGIC_VECTOR (11 downto 0);
    signal redist20_vCount_uid714_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist21_rVStage_uid713_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_b_1_q : STD_LOGIC_VECTOR (15 downto 0);
    signal redist22_osig_uid710_prod_uid331_bc_uid9_fpComplexMulTest_b_1_q : STD_LOGIC_VECTOR (47 downto 0);
    signal redist23_osig_uid707_prod_uid241_ad_uid8_fpComplexMulTest_b_1_q : STD_LOGIC_VECTOR (47 downto 0);
    signal redist24_osig_uid704_prod_uid151_bd_uid7_fpComplexMulTest_b_1_q : STD_LOGIC_VECTOR (47 downto 0);
    signal redist25_osig_uid701_prod_uid61_ac_uid6_fpComplexMulTest_b_1_q : STD_LOGIC_VECTOR (47 downto 0);
    signal redist26_expRPreExc_uid664_rImag_uid17_fpComplexMulTest_b_2_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist27_fracRPreExc_uid663_rImag_uid17_fpComplexMulTest_b_2_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist28_fracPostNormRndRange_uid649_rImag_uid17_fpComplexMulTest_b_1_q : STD_LOGIC_VECTOR (23 downto 0);
    signal redist29_expPostNorm_uid639_rImag_uid17_fpComplexMulTest_q_2_q : STD_LOGIC_VECTOR (9 downto 0);
    signal redist30_aMinusA_uid634_rImag_uid17_fpComplexMulTest_q_3_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist31_fracGRS_uid631_rImag_uid17_fpComplexMulTest_q_1_q : STD_LOGIC_VECTOR (27 downto 0);
    signal redist32_fracGRS_uid631_rImag_uid17_fpComplexMulTest_q_2_q : STD_LOGIC_VECTOR (27 downto 0);
    signal redist33_cmpEQ_stickyBits_cZwF_uid618_rImag_uid17_fpComplexMulTest_q_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist34_effSub_uid597_rImag_uid17_fpComplexMulTest_q_7_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist35_sigB_uid596_rImag_uid17_fpComplexMulTest_b_3_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist36_sigB_uid596_rImag_uid17_fpComplexMulTest_b_9_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist37_sigA_uid595_rImag_uid17_fpComplexMulTest_b_3_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist38_sigA_uid595_rImag_uid17_fpComplexMulTest_b_9_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist39_fracB_uid594_rImag_uid17_fpComplexMulTest_b_1_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist40_fracA_uid593_rImag_uid17_fpComplexMulTest_b_4_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist41_expA_uid591_rImag_uid17_fpComplexMulTest_b_6_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist42_excBZ_uid590_rImag_uid17_fpComplexMulTest_q_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist43_excBZ_uid590_rImag_uid17_fpComplexMulTest_q_9_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist44_excBI_uid587_rImag_uid17_fpComplexMulTest_q_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist45_excAZ_uid586_rImag_uid17_fpComplexMulTest_q_9_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist46_excAI_uid583_rImag_uid17_fpComplexMulTest_q_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist47_sigY_uid576_rImag_uid17_fpComplexMulTest_b_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist48_expY_uid575_rImag_uid17_fpComplexMulTest_b_1_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist49_fracY_uid574_rImag_uid17_fpComplexMulTest_b_1_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist50_xGTEy_uid573_rImag_uid17_fpComplexMulTest_q_9_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist51_excX_uid559_rImag_uid17_fpComplexMulTest_b_10_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist52_excX_uid545_rImag_uid17_fpComplexMulTest_b_9_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist53_expRPreExc_uid504_rReal_uid16_fpComplexMulTest_b_2_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist54_fracRPreExc_uid503_rReal_uid16_fpComplexMulTest_b_2_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist55_fracPostNormRndRange_uid489_rReal_uid16_fpComplexMulTest_b_1_q : STD_LOGIC_VECTOR (23 downto 0);
    signal redist56_expPostNorm_uid479_rReal_uid16_fpComplexMulTest_q_2_q : STD_LOGIC_VECTOR (9 downto 0);
    signal redist57_aMinusA_uid474_rReal_uid16_fpComplexMulTest_q_3_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist58_fracGRS_uid471_rReal_uid16_fpComplexMulTest_q_1_q : STD_LOGIC_VECTOR (27 downto 0);
    signal redist59_fracGRS_uid471_rReal_uid16_fpComplexMulTest_q_2_q : STD_LOGIC_VECTOR (27 downto 0);
    signal redist60_cmpEQ_stickyBits_cZwF_uid458_rReal_uid16_fpComplexMulTest_q_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist61_effSub_uid437_rReal_uid16_fpComplexMulTest_q_7_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist62_sigB_uid436_rReal_uid16_fpComplexMulTest_b_3_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist63_sigB_uid436_rReal_uid16_fpComplexMulTest_b_9_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist64_sigA_uid435_rReal_uid16_fpComplexMulTest_b_3_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist65_sigA_uid435_rReal_uid16_fpComplexMulTest_b_9_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist66_fracB_uid434_rReal_uid16_fpComplexMulTest_b_1_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist67_fracA_uid433_rReal_uid16_fpComplexMulTest_b_4_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist68_expA_uid431_rReal_uid16_fpComplexMulTest_b_6_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist69_excBZ_uid430_rReal_uid16_fpComplexMulTest_q_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist70_excBZ_uid430_rReal_uid16_fpComplexMulTest_q_9_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist71_excBI_uid427_rReal_uid16_fpComplexMulTest_q_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist72_excAZ_uid426_rReal_uid16_fpComplexMulTest_q_9_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist73_excAI_uid423_rReal_uid16_fpComplexMulTest_q_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist74_sigY_uid416_rReal_uid16_fpComplexMulTest_b_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist75_expY_uid415_rReal_uid16_fpComplexMulTest_b_1_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist76_fracY_uid414_rReal_uid16_fpComplexMulTest_b_1_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist77_xGTEy_uid413_rReal_uid16_fpComplexMulTest_q_9_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist78_excX_uid399_rReal_uid16_fpComplexMulTest_b_10_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist79_excX_uid385_rReal_uid16_fpComplexMulTest_b_9_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist80_expRPreExc_uid356_bc_uid9_fpComplexMulTest_b_1_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist81_expRPreExcExt_uid355_bc_uid9_fpComplexMulTest_b_1_q : STD_LOGIC_VECTOR (11 downto 0);
    signal redist82_fracRPreExc_uid354_bc_uid9_fpComplexMulTest_b_2_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist83_normalizeBit_uid333_bc_uid9_fpComplexMulTest_b_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist84_R_uid288_ad_uid8_fpComplexMulTest_q_1_q : STD_LOGIC_VECTOR (33 downto 0);
    signal redist85_expRPreExc_uid266_ad_uid8_fpComplexMulTest_b_1_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist86_expRPreExcExt_uid265_ad_uid8_fpComplexMulTest_b_1_q : STD_LOGIC_VECTOR (11 downto 0);
    signal redist87_fracRPreExc_uid264_ad_uid8_fpComplexMulTest_b_2_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist88_fracRPostNorm_uid247_ad_uid8_fpComplexMulTest_q_1_q : STD_LOGIC_VECTOR (23 downto 0);
    signal redist89_normalizeBit_uid243_ad_uid8_fpComplexMulTest_b_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist90_expRPreExc_uid176_bd_uid7_fpComplexMulTest_b_1_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist91_expRPreExcExt_uid175_bd_uid7_fpComplexMulTest_b_1_q : STD_LOGIC_VECTOR (11 downto 0);
    signal redist92_fracRPreExc_uid174_bd_uid7_fpComplexMulTest_b_2_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist93_fracRPostNorm_uid157_bd_uid7_fpComplexMulTest_q_1_q : STD_LOGIC_VECTOR (23 downto 0);
    signal redist94_normalizeBit_uid153_bd_uid7_fpComplexMulTest_b_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist95_fracXIsZero_uid135_bd_uid7_fpComplexMulTest_q_6_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist96_expXIsMax_uid134_bd_uid7_fpComplexMulTest_q_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist97_excZ_y_uid133_bd_uid7_fpComplexMulTest_q_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist98_fracXIsZero_uid121_bd_uid7_fpComplexMulTest_q_6_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist99_expXIsMax_uid120_bd_uid7_fpComplexMulTest_q_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist100_excZ_x_uid119_bd_uid7_fpComplexMulTest_q_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist101_signY_uid113_bd_uid7_fpComplexMulTest_b_6_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist102_signX_uid112_bd_uid7_fpComplexMulTest_b_6_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist103_expY_uid111_bd_uid7_fpComplexMulTest_b_4_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist104_expX_uid110_bd_uid7_fpComplexMulTest_b_4_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist105_R_uid108_ac_uid6_fpComplexMulTest_q_1_q : STD_LOGIC_VECTOR (33 downto 0);
    signal redist106_expRPreExc_uid86_ac_uid6_fpComplexMulTest_b_1_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist107_expRPreExcExt_uid85_ac_uid6_fpComplexMulTest_b_1_q : STD_LOGIC_VECTOR (11 downto 0);
    signal redist108_fracRPreExc_uid84_ac_uid6_fpComplexMulTest_b_2_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist109_fracRPostNorm_uid67_ac_uid6_fpComplexMulTest_q_1_q : STD_LOGIC_VECTOR (23 downto 0);
    signal redist110_normalizeBit_uid63_ac_uid6_fpComplexMulTest_b_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist111_fracXIsZero_uid45_ac_uid6_fpComplexMulTest_q_6_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist112_expXIsMax_uid44_ac_uid6_fpComplexMulTest_q_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist113_excZ_y_uid43_ac_uid6_fpComplexMulTest_q_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist114_fracXIsZero_uid31_ac_uid6_fpComplexMulTest_q_6_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist115_expXIsMax_uid30_ac_uid6_fpComplexMulTest_q_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist116_excZ_x_uid29_ac_uid6_fpComplexMulTest_q_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist117_signY_uid23_ac_uid6_fpComplexMulTest_b_6_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist118_signX_uid22_ac_uid6_fpComplexMulTest_b_6_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist119_expY_uid21_ac_uid6_fpComplexMulTest_b_4_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist120_expX_uid20_ac_uid6_fpComplexMulTest_b_4_q : STD_LOGIC_VECTOR (7 downto 0);

begin


    -- cAmA_uid473_rReal_uid16_fpComplexMulTest(CONSTANT,472)
    cAmA_uid473_rReal_uid16_fpComplexMulTest_q <= "11100";

    -- zs_uid712_lzCountVal_uid472_rReal_uid16_fpComplexMulTest(CONSTANT,711)
    zs_uid712_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q <= "0000000000000000";

    -- frac_x_uid118_bd_uid7_fpComplexMulTest(BITSELECT,117)@0
    frac_x_uid118_bd_uid7_fpComplexMulTest_b <= b(22 downto 0);

    -- cstZeroWF_uid25_ac_uid6_fpComplexMulTest(CONSTANT,24)
    cstZeroWF_uid25_ac_uid6_fpComplexMulTest_q <= "00000000000000000000000";

    -- fracXIsZero_uid121_bd_uid7_fpComplexMulTest(LOGICAL,120)@0 + 1
    fracXIsZero_uid121_bd_uid7_fpComplexMulTest_qi <= "1" WHEN cstZeroWF_uid25_ac_uid6_fpComplexMulTest_q = frac_x_uid118_bd_uid7_fpComplexMulTest_b ELSE "0";
    fracXIsZero_uid121_bd_uid7_fpComplexMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => fracXIsZero_uid121_bd_uid7_fpComplexMulTest_qi, xout => fracXIsZero_uid121_bd_uid7_fpComplexMulTest_q, clk => clk, aclr => areset );

    -- redist98_fracXIsZero_uid121_bd_uid7_fpComplexMulTest_q_6(DELAY,1179)
    redist98_fracXIsZero_uid121_bd_uid7_fpComplexMulTest_q_6 : dspba_delay
    GENERIC MAP ( width => 1, depth => 5, reset_kind => "ASYNC" )
    PORT MAP ( xin => fracXIsZero_uid121_bd_uid7_fpComplexMulTest_q, xout => redist98_fracXIsZero_uid121_bd_uid7_fpComplexMulTest_q_6_q, clk => clk, aclr => areset );

    -- cstAllOWE_uid24_ac_uid6_fpComplexMulTest(CONSTANT,23)
    cstAllOWE_uid24_ac_uid6_fpComplexMulTest_q <= "11111111";

    -- expX_uid110_bd_uid7_fpComplexMulTest(BITSELECT,109)@0
    expX_uid110_bd_uid7_fpComplexMulTest_b <= b(30 downto 23);

    -- redist104_expX_uid110_bd_uid7_fpComplexMulTest_b_4(DELAY,1185)
    redist104_expX_uid110_bd_uid7_fpComplexMulTest_b_4 : dspba_delay
    GENERIC MAP ( width => 8, depth => 4, reset_kind => "ASYNC" )
    PORT MAP ( xin => expX_uid110_bd_uid7_fpComplexMulTest_b, xout => redist104_expX_uid110_bd_uid7_fpComplexMulTest_b_4_q, clk => clk, aclr => areset );

    -- expXIsMax_uid120_bd_uid7_fpComplexMulTest(LOGICAL,119)@4 + 1
    expXIsMax_uid120_bd_uid7_fpComplexMulTest_qi <= "1" WHEN redist104_expX_uid110_bd_uid7_fpComplexMulTest_b_4_q = cstAllOWE_uid24_ac_uid6_fpComplexMulTest_q ELSE "0";
    expXIsMax_uid120_bd_uid7_fpComplexMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => expXIsMax_uid120_bd_uid7_fpComplexMulTest_qi, xout => expXIsMax_uid120_bd_uid7_fpComplexMulTest_q, clk => clk, aclr => areset );

    -- redist99_expXIsMax_uid120_bd_uid7_fpComplexMulTest_q_2(DELAY,1180)
    redist99_expXIsMax_uid120_bd_uid7_fpComplexMulTest_q_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => expXIsMax_uid120_bd_uid7_fpComplexMulTest_q, xout => redist99_expXIsMax_uid120_bd_uid7_fpComplexMulTest_q_2_q, clk => clk, aclr => areset );

    -- excI_x_uid123_bd_uid7_fpComplexMulTest(LOGICAL,122)@6
    excI_x_uid123_bd_uid7_fpComplexMulTest_q <= redist99_expXIsMax_uid120_bd_uid7_fpComplexMulTest_q_2_q and redist98_fracXIsZero_uid121_bd_uid7_fpComplexMulTest_q_6_q;

    -- cstAllZWE_uid26_ac_uid6_fpComplexMulTest(CONSTANT,25)
    cstAllZWE_uid26_ac_uid6_fpComplexMulTest_q <= "00000000";

    -- expY_uid21_ac_uid6_fpComplexMulTest(BITSELECT,20)@0
    expY_uid21_ac_uid6_fpComplexMulTest_b <= c(30 downto 23);

    -- redist119_expY_uid21_ac_uid6_fpComplexMulTest_b_4(DELAY,1200)
    redist119_expY_uid21_ac_uid6_fpComplexMulTest_b_4 : dspba_delay
    GENERIC MAP ( width => 8, depth => 4, reset_kind => "ASYNC" )
    PORT MAP ( xin => expY_uid21_ac_uid6_fpComplexMulTest_b, xout => redist119_expY_uid21_ac_uid6_fpComplexMulTest_b_4_q, clk => clk, aclr => areset );

    -- excZ_y_uid43_ac_uid6_fpComplexMulTest(LOGICAL,42)@4 + 1
    excZ_y_uid43_ac_uid6_fpComplexMulTest_qi <= "1" WHEN redist119_expY_uid21_ac_uid6_fpComplexMulTest_b_4_q = cstAllZWE_uid26_ac_uid6_fpComplexMulTest_q ELSE "0";
    excZ_y_uid43_ac_uid6_fpComplexMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => excZ_y_uid43_ac_uid6_fpComplexMulTest_qi, xout => excZ_y_uid43_ac_uid6_fpComplexMulTest_q, clk => clk, aclr => areset );

    -- redist113_excZ_y_uid43_ac_uid6_fpComplexMulTest_q_2(DELAY,1194)
    redist113_excZ_y_uid43_ac_uid6_fpComplexMulTest_q_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => excZ_y_uid43_ac_uid6_fpComplexMulTest_q, xout => redist113_excZ_y_uid43_ac_uid6_fpComplexMulTest_q_2_q, clk => clk, aclr => areset );

    -- excYZAndExcXI_uid370_bc_uid9_fpComplexMulTest(LOGICAL,369)@6
    excYZAndExcXI_uid370_bc_uid9_fpComplexMulTest_q <= redist113_excZ_y_uid43_ac_uid6_fpComplexMulTest_q_2_q and excI_x_uid123_bd_uid7_fpComplexMulTest_q;

    -- frac_y_uid42_ac_uid6_fpComplexMulTest(BITSELECT,41)@0
    frac_y_uid42_ac_uid6_fpComplexMulTest_b <= c(22 downto 0);

    -- fracXIsZero_uid45_ac_uid6_fpComplexMulTest(LOGICAL,44)@0 + 1
    fracXIsZero_uid45_ac_uid6_fpComplexMulTest_qi <= "1" WHEN cstZeroWF_uid25_ac_uid6_fpComplexMulTest_q = frac_y_uid42_ac_uid6_fpComplexMulTest_b ELSE "0";
    fracXIsZero_uid45_ac_uid6_fpComplexMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => fracXIsZero_uid45_ac_uid6_fpComplexMulTest_qi, xout => fracXIsZero_uid45_ac_uid6_fpComplexMulTest_q, clk => clk, aclr => areset );

    -- redist111_fracXIsZero_uid45_ac_uid6_fpComplexMulTest_q_6(DELAY,1192)
    redist111_fracXIsZero_uid45_ac_uid6_fpComplexMulTest_q_6 : dspba_delay
    GENERIC MAP ( width => 1, depth => 5, reset_kind => "ASYNC" )
    PORT MAP ( xin => fracXIsZero_uid45_ac_uid6_fpComplexMulTest_q, xout => redist111_fracXIsZero_uid45_ac_uid6_fpComplexMulTest_q_6_q, clk => clk, aclr => areset );

    -- expXIsMax_uid44_ac_uid6_fpComplexMulTest(LOGICAL,43)@4 + 1
    expXIsMax_uid44_ac_uid6_fpComplexMulTest_qi <= "1" WHEN redist119_expY_uid21_ac_uid6_fpComplexMulTest_b_4_q = cstAllOWE_uid24_ac_uid6_fpComplexMulTest_q ELSE "0";
    expXIsMax_uid44_ac_uid6_fpComplexMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => expXIsMax_uid44_ac_uid6_fpComplexMulTest_qi, xout => expXIsMax_uid44_ac_uid6_fpComplexMulTest_q, clk => clk, aclr => areset );

    -- redist112_expXIsMax_uid44_ac_uid6_fpComplexMulTest_q_2(DELAY,1193)
    redist112_expXIsMax_uid44_ac_uid6_fpComplexMulTest_q_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => expXIsMax_uid44_ac_uid6_fpComplexMulTest_q, xout => redist112_expXIsMax_uid44_ac_uid6_fpComplexMulTest_q_2_q, clk => clk, aclr => areset );

    -- excI_y_uid47_ac_uid6_fpComplexMulTest(LOGICAL,46)@6
    excI_y_uid47_ac_uid6_fpComplexMulTest_q <= redist112_expXIsMax_uid44_ac_uid6_fpComplexMulTest_q_2_q and redist111_fracXIsZero_uid45_ac_uid6_fpComplexMulTest_q_6_q;

    -- excZ_x_uid119_bd_uid7_fpComplexMulTest(LOGICAL,118)@4 + 1
    excZ_x_uid119_bd_uid7_fpComplexMulTest_qi <= "1" WHEN redist104_expX_uid110_bd_uid7_fpComplexMulTest_b_4_q = cstAllZWE_uid26_ac_uid6_fpComplexMulTest_q ELSE "0";
    excZ_x_uid119_bd_uid7_fpComplexMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => excZ_x_uid119_bd_uid7_fpComplexMulTest_qi, xout => excZ_x_uid119_bd_uid7_fpComplexMulTest_q, clk => clk, aclr => areset );

    -- redist100_excZ_x_uid119_bd_uid7_fpComplexMulTest_q_2(DELAY,1181)
    redist100_excZ_x_uid119_bd_uid7_fpComplexMulTest_q_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => excZ_x_uid119_bd_uid7_fpComplexMulTest_q, xout => redist100_excZ_x_uid119_bd_uid7_fpComplexMulTest_q_2_q, clk => clk, aclr => areset );

    -- excXZAndExcYI_uid371_bc_uid9_fpComplexMulTest(LOGICAL,370)@6
    excXZAndExcYI_uid371_bc_uid9_fpComplexMulTest_q <= redist100_excZ_x_uid119_bd_uid7_fpComplexMulTest_q_2_q and excI_y_uid47_ac_uid6_fpComplexMulTest_q;

    -- ZeroTimesInf_uid372_bc_uid9_fpComplexMulTest(LOGICAL,371)@6
    ZeroTimesInf_uid372_bc_uid9_fpComplexMulTest_q <= excXZAndExcYI_uid371_bc_uid9_fpComplexMulTest_q or excYZAndExcXI_uid370_bc_uid9_fpComplexMulTest_q;

    -- fracXIsNotZero_uid46_ac_uid6_fpComplexMulTest(LOGICAL,45)@6
    fracXIsNotZero_uid46_ac_uid6_fpComplexMulTest_q <= not (redist111_fracXIsZero_uid45_ac_uid6_fpComplexMulTest_q_6_q);

    -- excN_y_uid48_ac_uid6_fpComplexMulTest(LOGICAL,47)@6
    excN_y_uid48_ac_uid6_fpComplexMulTest_q <= redist112_expXIsMax_uid44_ac_uid6_fpComplexMulTest_q_2_q and fracXIsNotZero_uid46_ac_uid6_fpComplexMulTest_q;

    -- fracXIsNotZero_uid122_bd_uid7_fpComplexMulTest(LOGICAL,121)@6
    fracXIsNotZero_uid122_bd_uid7_fpComplexMulTest_q <= not (redist98_fracXIsZero_uid121_bd_uid7_fpComplexMulTest_q_6_q);

    -- excN_x_uid124_bd_uid7_fpComplexMulTest(LOGICAL,123)@6
    excN_x_uid124_bd_uid7_fpComplexMulTest_q <= redist99_expXIsMax_uid120_bd_uid7_fpComplexMulTest_q_2_q and fracXIsNotZero_uid122_bd_uid7_fpComplexMulTest_q;

    -- excRNaN_uid373_bc_uid9_fpComplexMulTest(LOGICAL,372)@6 + 1
    excRNaN_uid373_bc_uid9_fpComplexMulTest_qi <= excN_x_uid124_bd_uid7_fpComplexMulTest_q or excN_y_uid48_ac_uid6_fpComplexMulTest_q or ZeroTimesInf_uid372_bc_uid9_fpComplexMulTest_q;
    excRNaN_uid373_bc_uid9_fpComplexMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => excRNaN_uid373_bc_uid9_fpComplexMulTest_qi, xout => excRNaN_uid373_bc_uid9_fpComplexMulTest_q, clk => clk, aclr => areset );

    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- ofracX_uid144_bd_uid7_fpComplexMulTest(BITJOIN,143)@0
    ofracX_uid144_bd_uid7_fpComplexMulTest_q <= VCC_q & frac_x_uid118_bd_uid7_fpComplexMulTest_b;

    -- prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_bs1_merged_bit_select(BITSELECT,1061)@0
    prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_bs1_merged_bit_select_b <= ofracX_uid144_bd_uid7_fpComplexMulTest_q(17 downto 0);
    prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_bs1_merged_bit_select_c <= ofracX_uid144_bd_uid7_fpComplexMulTest_q(23 downto 18);

    -- redist11_prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_bs1_merged_bit_select_c_1(DELAY,1092)
    redist11_prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_bs1_merged_bit_select_c_1 : dspba_delay
    GENERIC MAP ( width => 6, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_bs1_merged_bit_select_c, xout => redist11_prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_bs1_merged_bit_select_c_1_q, clk => clk, aclr => areset );

    -- ofracY_uid57_ac_uid6_fpComplexMulTest(BITJOIN,56)@0
    ofracY_uid57_ac_uid6_fpComplexMulTest_q <= VCC_q & frac_y_uid42_ac_uid6_fpComplexMulTest_b;

    -- prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_bs2_merged_bit_select(BITSELECT,1060)@0
    prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_bs2_merged_bit_select_b <= ofracY_uid57_ac_uid6_fpComplexMulTest_q(17 downto 0);
    prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_bs2_merged_bit_select_c <= ofracY_uid57_ac_uid6_fpComplexMulTest_q(23 downto 18);

    -- redist12_prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_bs2_merged_bit_select_b_1(DELAY,1093)
    redist12_prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_bs2_merged_bit_select_b_1 : dspba_delay
    GENERIC MAP ( width => 18, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_bs2_merged_bit_select_b, xout => redist12_prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_bs2_merged_bit_select_b_1_q, clk => clk, aclr => areset );

    -- prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im6(MULT,1016)@1 + 2
    prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im6_a0 <= redist12_prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_bs2_merged_bit_select_b_1_q;
    prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im6_b0 <= redist11_prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_bs1_merged_bit_select_c_1_q;
    prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im6_reset <= areset;
    prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im6_component : lpm_mult
    GENERIC MAP (
        lpm_widtha => 18,
        lpm_widthb => 6,
        lpm_widthp => 24,
        lpm_widths => 1,
        lpm_type => "LPM_MULT",
        lpm_representation => "UNSIGNED",
        lpm_hint => "DEDICATED_MULTIPLIER_CIRCUITRY=YES, MAXIMIZE_SPEED=5",
        lpm_pipeline => 2
    )
    PORT MAP (
        dataa => prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im6_a0,
        datab => prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im6_b0,
        clken => VCC_q(0),
        aclr => prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im6_reset,
        clock => clk,
        result => prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im6_s1
    );
    prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im6_q <= prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im6_s1;

    -- prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_align_15(BITSHIFT,1025)@3
    prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_align_15_qint <= prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im6_q & "000000000000000000";
    prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_align_15_q <= prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_align_15_qint(41 downto 0);

    -- prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im3(MULT,1013)@0 + 2
    prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im3_a0 <= prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_bs1_merged_bit_select_b;
    prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im3_b0 <= prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_bs2_merged_bit_select_c;
    prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im3_reset <= areset;
    prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im3_component : lpm_mult
    GENERIC MAP (
        lpm_widtha => 18,
        lpm_widthb => 6,
        lpm_widthp => 24,
        lpm_widths => 1,
        lpm_type => "LPM_MULT",
        lpm_representation => "UNSIGNED",
        lpm_hint => "DEDICATED_MULTIPLIER_CIRCUITRY=YES, MAXIMIZE_SPEED=5",
        lpm_pipeline => 2
    )
    PORT MAP (
        dataa => prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im3_a0,
        datab => prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im3_b0,
        clken => VCC_q(0),
        aclr => prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im3_reset,
        clock => clk,
        result => prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im3_s1
    );
    prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im3_q <= prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im3_s1;

    -- prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_align_13(BITSHIFT,1023)@2
    prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_align_13_qint <= prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im3_q & "000000000000000000";
    prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_align_13_q <= prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_align_13_qint(41 downto 0);

    -- prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im9(MULT,1019)@0 + 2
    prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im9_a0 <= prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_bs1_merged_bit_select_c;
    prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im9_b0 <= prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_bs2_merged_bit_select_c;
    prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im9_reset <= areset;
    prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im9_component : lpm_mult
    GENERIC MAP (
        lpm_widtha => 6,
        lpm_widthb => 6,
        lpm_widthp => 12,
        lpm_widths => 1,
        lpm_type => "LPM_MULT",
        lpm_representation => "UNSIGNED",
        lpm_hint => "DEDICATED_MULTIPLIER_CIRCUITRY=YES, MAXIMIZE_SPEED=5",
        lpm_pipeline => 2
    )
    PORT MAP (
        dataa => prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im9_a0,
        datab => prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im9_b0,
        clken => VCC_q(0),
        aclr => prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im9_reset,
        clock => clk,
        result => prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im9_s1
    );
    prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im9_q <= prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im9_s1;

    -- prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im0(MULT,1010)@0 + 2
    prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im0_a0 <= prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_bs1_merged_bit_select_b;
    prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im0_b0 <= prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_bs2_merged_bit_select_b;
    prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im0_reset <= areset;
    prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im0_component : lpm_mult
    GENERIC MAP (
        lpm_widtha => 18,
        lpm_widthb => 18,
        lpm_widthp => 36,
        lpm_widths => 1,
        lpm_type => "LPM_MULT",
        lpm_representation => "UNSIGNED",
        lpm_hint => "DEDICATED_MULTIPLIER_CIRCUITRY=YES, MAXIMIZE_SPEED=5",
        lpm_pipeline => 2
    )
    PORT MAP (
        dataa => prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im0_a0,
        datab => prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im0_b0,
        clken => VCC_q(0),
        aclr => prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im0_reset,
        clock => clk,
        result => prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im0_s1
    );
    prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im0_q <= prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im0_s1;

    -- prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_join_12(BITJOIN,1022)@2
    prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_join_12_q <= prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im9_q & prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_im0_q;

    -- prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_result_add_0_0(ADD,1027)@2 + 1
    prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_result_add_0_0_a <= STD_LOGIC_VECTOR("0" & prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_join_12_q);
    prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_result_add_0_0_b <= STD_LOGIC_VECTOR("0000000" & prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_align_13_q);
    prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_result_add_0_0_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_result_add_0_0_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_result_add_0_0_o <= STD_LOGIC_VECTOR(UNSIGNED(prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_result_add_0_0_a) + UNSIGNED(prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_result_add_0_0_b));
        END IF;
    END PROCESS;
    prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_result_add_0_0_q <= prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_result_add_0_0_o(48 downto 0);

    -- prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_result_add_1_0(ADD,1028)@3
    prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_result_add_1_0_a <= STD_LOGIC_VECTOR("0" & prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_result_add_0_0_q);
    prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_result_add_1_0_b <= STD_LOGIC_VECTOR("00000000" & prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_align_15_q);
    prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_result_add_1_0_o <= STD_LOGIC_VECTOR(UNSIGNED(prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_result_add_1_0_a) + UNSIGNED(prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_result_add_1_0_b));
    prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_result_add_1_0_q <= prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_result_add_1_0_o(49 downto 0);

    -- osig_uid710_prod_uid331_bc_uid9_fpComplexMulTest(BITSELECT,709)@3
    osig_uid710_prod_uid331_bc_uid9_fpComplexMulTest_in <= prodXY_uid709_prod_uid331_bc_uid9_fpComplexMulTest_result_add_1_0_q(47 downto 0);
    osig_uid710_prod_uid331_bc_uid9_fpComplexMulTest_b <= osig_uid710_prod_uid331_bc_uid9_fpComplexMulTest_in(47 downto 0);

    -- redist22_osig_uid710_prod_uid331_bc_uid9_fpComplexMulTest_b_1(DELAY,1103)
    redist22_osig_uid710_prod_uid331_bc_uid9_fpComplexMulTest_b_1 : dspba_delay
    GENERIC MAP ( width => 48, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => osig_uid710_prod_uid331_bc_uid9_fpComplexMulTest_b, xout => redist22_osig_uid710_prod_uid331_bc_uid9_fpComplexMulTest_b_1_q, clk => clk, aclr => areset );

    -- normalizeBit_uid333_bc_uid9_fpComplexMulTest(BITSELECT,332)@4
    normalizeBit_uid333_bc_uid9_fpComplexMulTest_b <= STD_LOGIC_VECTOR(redist22_osig_uid710_prod_uid331_bc_uid9_fpComplexMulTest_b_1_q(47 downto 47));

    -- redist83_normalizeBit_uid333_bc_uid9_fpComplexMulTest_b_1(DELAY,1164)
    redist83_normalizeBit_uid333_bc_uid9_fpComplexMulTest_b_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => normalizeBit_uid333_bc_uid9_fpComplexMulTest_b, xout => redist83_normalizeBit_uid333_bc_uid9_fpComplexMulTest_b_1_q, clk => clk, aclr => areset );

    -- roundBitDetectionConstant_uid77_ac_uid6_fpComplexMulTest(CONSTANT,76)
    roundBitDetectionConstant_uid77_ac_uid6_fpComplexMulTest_q <= "010";

    -- fracRPostNormHigh_uid335_bc_uid9_fpComplexMulTest(BITSELECT,334)@4
    fracRPostNormHigh_uid335_bc_uid9_fpComplexMulTest_in <= redist22_osig_uid710_prod_uid331_bc_uid9_fpComplexMulTest_b_1_q(46 downto 0);
    fracRPostNormHigh_uid335_bc_uid9_fpComplexMulTest_b <= fracRPostNormHigh_uid335_bc_uid9_fpComplexMulTest_in(46 downto 23);

    -- fracRPostNormLow_uid336_bc_uid9_fpComplexMulTest(BITSELECT,335)@4
    fracRPostNormLow_uid336_bc_uid9_fpComplexMulTest_in <= redist22_osig_uid710_prod_uid331_bc_uid9_fpComplexMulTest_b_1_q(45 downto 0);
    fracRPostNormLow_uid336_bc_uid9_fpComplexMulTest_b <= fracRPostNormLow_uid336_bc_uid9_fpComplexMulTest_in(45 downto 22);

    -- fracRPostNorm_uid337_bc_uid9_fpComplexMulTest(MUX,336)@4 + 1
    fracRPostNorm_uid337_bc_uid9_fpComplexMulTest_s <= normalizeBit_uid333_bc_uid9_fpComplexMulTest_b;
    fracRPostNorm_uid337_bc_uid9_fpComplexMulTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            fracRPostNorm_uid337_bc_uid9_fpComplexMulTest_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            CASE (fracRPostNorm_uid337_bc_uid9_fpComplexMulTest_s) IS
                WHEN "0" => fracRPostNorm_uid337_bc_uid9_fpComplexMulTest_q <= fracRPostNormLow_uid336_bc_uid9_fpComplexMulTest_b;
                WHEN "1" => fracRPostNorm_uid337_bc_uid9_fpComplexMulTest_q <= fracRPostNormHigh_uid335_bc_uid9_fpComplexMulTest_b;
                WHEN OTHERS => fracRPostNorm_uid337_bc_uid9_fpComplexMulTest_q <= (others => '0');
            END CASE;
        END IF;
    END PROCESS;

    -- fracRPostNorm1dto0_uid345_bc_uid9_fpComplexMulTest(BITSELECT,344)@5
    fracRPostNorm1dto0_uid345_bc_uid9_fpComplexMulTest_in <= fracRPostNorm_uid337_bc_uid9_fpComplexMulTest_q(1 downto 0);
    fracRPostNorm1dto0_uid345_bc_uid9_fpComplexMulTest_b <= fracRPostNorm1dto0_uid345_bc_uid9_fpComplexMulTest_in(1 downto 0);

    -- extraStickyBitOfProd_uid339_bc_uid9_fpComplexMulTest(BITSELECT,338)@4
    extraStickyBitOfProd_uid339_bc_uid9_fpComplexMulTest_in <= STD_LOGIC_VECTOR(redist22_osig_uid710_prod_uid331_bc_uid9_fpComplexMulTest_b_1_q(22 downto 0));
    extraStickyBitOfProd_uid339_bc_uid9_fpComplexMulTest_b <= STD_LOGIC_VECTOR(extraStickyBitOfProd_uid339_bc_uid9_fpComplexMulTest_in(22 downto 22));

    -- extraStickyBit_uid340_bc_uid9_fpComplexMulTest(MUX,339)@4
    extraStickyBit_uid340_bc_uid9_fpComplexMulTest_s <= normalizeBit_uid333_bc_uid9_fpComplexMulTest_b;
    extraStickyBit_uid340_bc_uid9_fpComplexMulTest_combproc: PROCESS (extraStickyBit_uid340_bc_uid9_fpComplexMulTest_s, GND_q, extraStickyBitOfProd_uid339_bc_uid9_fpComplexMulTest_b)
    BEGIN
        CASE (extraStickyBit_uid340_bc_uid9_fpComplexMulTest_s) IS
            WHEN "0" => extraStickyBit_uid340_bc_uid9_fpComplexMulTest_q <= GND_q;
            WHEN "1" => extraStickyBit_uid340_bc_uid9_fpComplexMulTest_q <= extraStickyBitOfProd_uid339_bc_uid9_fpComplexMulTest_b;
            WHEN OTHERS => extraStickyBit_uid340_bc_uid9_fpComplexMulTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- stickyRange_uid338_bc_uid9_fpComplexMulTest(BITSELECT,337)@4
    stickyRange_uid338_bc_uid9_fpComplexMulTest_in <= redist22_osig_uid710_prod_uid331_bc_uid9_fpComplexMulTest_b_1_q(21 downto 0);
    stickyRange_uid338_bc_uid9_fpComplexMulTest_b <= stickyRange_uid338_bc_uid9_fpComplexMulTest_in(21 downto 0);

    -- stickyExtendedRange_uid341_bc_uid9_fpComplexMulTest(BITJOIN,340)@4
    stickyExtendedRange_uid341_bc_uid9_fpComplexMulTest_q <= extraStickyBit_uid340_bc_uid9_fpComplexMulTest_q & stickyRange_uid338_bc_uid9_fpComplexMulTest_b;

    -- stickyRangeComparator_uid343_bc_uid9_fpComplexMulTest(LOGICAL,342)@4 + 1
    stickyRangeComparator_uid343_bc_uid9_fpComplexMulTest_qi <= "1" WHEN stickyExtendedRange_uid341_bc_uid9_fpComplexMulTest_q = cstZeroWF_uid25_ac_uid6_fpComplexMulTest_q ELSE "0";
    stickyRangeComparator_uid343_bc_uid9_fpComplexMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => stickyRangeComparator_uid343_bc_uid9_fpComplexMulTest_qi, xout => stickyRangeComparator_uid343_bc_uid9_fpComplexMulTest_q, clk => clk, aclr => areset );

    -- sticky_uid344_bc_uid9_fpComplexMulTest(LOGICAL,343)@5
    sticky_uid344_bc_uid9_fpComplexMulTest_q <= not (stickyRangeComparator_uid343_bc_uid9_fpComplexMulTest_q);

    -- lrs_uid346_bc_uid9_fpComplexMulTest(BITJOIN,345)@5
    lrs_uid346_bc_uid9_fpComplexMulTest_q <= fracRPostNorm1dto0_uid345_bc_uid9_fpComplexMulTest_b & sticky_uid344_bc_uid9_fpComplexMulTest_q;

    -- roundBitDetectionPattern_uid348_bc_uid9_fpComplexMulTest(LOGICAL,347)@5
    roundBitDetectionPattern_uid348_bc_uid9_fpComplexMulTest_q <= "1" WHEN lrs_uid346_bc_uid9_fpComplexMulTest_q = roundBitDetectionConstant_uid77_ac_uid6_fpComplexMulTest_q ELSE "0";

    -- roundBit_uid349_bc_uid9_fpComplexMulTest(LOGICAL,348)@5
    roundBit_uid349_bc_uid9_fpComplexMulTest_q <= not (roundBitDetectionPattern_uid348_bc_uid9_fpComplexMulTest_q);

    -- roundBitAndNormalizationOp_uid352_bc_uid9_fpComplexMulTest(BITJOIN,351)@5
    roundBitAndNormalizationOp_uid352_bc_uid9_fpComplexMulTest_q <= GND_q & redist83_normalizeBit_uid333_bc_uid9_fpComplexMulTest_b_1_q & cstZeroWF_uid25_ac_uid6_fpComplexMulTest_q & roundBit_uid349_bc_uid9_fpComplexMulTest_q;

    -- biasInc_uid59_ac_uid6_fpComplexMulTest(CONSTANT,58)
    biasInc_uid59_ac_uid6_fpComplexMulTest_q <= "0001111111";

    -- expSum_uid328_bc_uid9_fpComplexMulTest(ADD,327)@4
    expSum_uid328_bc_uid9_fpComplexMulTest_a <= STD_LOGIC_VECTOR("0" & redist104_expX_uid110_bd_uid7_fpComplexMulTest_b_4_q);
    expSum_uid328_bc_uid9_fpComplexMulTest_b <= STD_LOGIC_VECTOR("0" & redist119_expY_uid21_ac_uid6_fpComplexMulTest_b_4_q);
    expSum_uid328_bc_uid9_fpComplexMulTest_o <= STD_LOGIC_VECTOR(UNSIGNED(expSum_uid328_bc_uid9_fpComplexMulTest_a) + UNSIGNED(expSum_uid328_bc_uid9_fpComplexMulTest_b));
    expSum_uid328_bc_uid9_fpComplexMulTest_q <= expSum_uid328_bc_uid9_fpComplexMulTest_o(8 downto 0);

    -- expSumMBias_uid330_bc_uid9_fpComplexMulTest(SUB,329)@4 + 1
    expSumMBias_uid330_bc_uid9_fpComplexMulTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & expSum_uid328_bc_uid9_fpComplexMulTest_q));
    expSumMBias_uid330_bc_uid9_fpComplexMulTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((11 downto 10 => biasInc_uid59_ac_uid6_fpComplexMulTest_q(9)) & biasInc_uid59_ac_uid6_fpComplexMulTest_q));
    expSumMBias_uid330_bc_uid9_fpComplexMulTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            expSumMBias_uid330_bc_uid9_fpComplexMulTest_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            expSumMBias_uid330_bc_uid9_fpComplexMulTest_o <= STD_LOGIC_VECTOR(SIGNED(expSumMBias_uid330_bc_uid9_fpComplexMulTest_a) - SIGNED(expSumMBias_uid330_bc_uid9_fpComplexMulTest_b));
        END IF;
    END PROCESS;
    expSumMBias_uid330_bc_uid9_fpComplexMulTest_q <= expSumMBias_uid330_bc_uid9_fpComplexMulTest_o(10 downto 0);

    -- expFracPreRound_uid350_bc_uid9_fpComplexMulTest(BITJOIN,349)@5
    expFracPreRound_uid350_bc_uid9_fpComplexMulTest_q <= expSumMBias_uid330_bc_uid9_fpComplexMulTest_q & fracRPostNorm_uid337_bc_uid9_fpComplexMulTest_q;

    -- expFracRPostRounding_uid353_bc_uid9_fpComplexMulTest(ADD,352)@5
    expFracRPostRounding_uid353_bc_uid9_fpComplexMulTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((36 downto 35 => expFracPreRound_uid350_bc_uid9_fpComplexMulTest_q(34)) & expFracPreRound_uid350_bc_uid9_fpComplexMulTest_q));
    expFracRPostRounding_uid353_bc_uid9_fpComplexMulTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("00000000000" & roundBitAndNormalizationOp_uid352_bc_uid9_fpComplexMulTest_q));
    expFracRPostRounding_uid353_bc_uid9_fpComplexMulTest_o <= STD_LOGIC_VECTOR(SIGNED(expFracRPostRounding_uid353_bc_uid9_fpComplexMulTest_a) + SIGNED(expFracRPostRounding_uid353_bc_uid9_fpComplexMulTest_b));
    expFracRPostRounding_uid353_bc_uid9_fpComplexMulTest_q <= expFracRPostRounding_uid353_bc_uid9_fpComplexMulTest_o(35 downto 0);

    -- expRPreExcExt_uid355_bc_uid9_fpComplexMulTest(BITSELECT,354)@5
    expRPreExcExt_uid355_bc_uid9_fpComplexMulTest_b <= STD_LOGIC_VECTOR(expFracRPostRounding_uid353_bc_uid9_fpComplexMulTest_q(35 downto 24));

    -- redist81_expRPreExcExt_uid355_bc_uid9_fpComplexMulTest_b_1(DELAY,1162)
    redist81_expRPreExcExt_uid355_bc_uid9_fpComplexMulTest_b_1 : dspba_delay
    GENERIC MAP ( width => 12, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => expRPreExcExt_uid355_bc_uid9_fpComplexMulTest_b, xout => redist81_expRPreExcExt_uid355_bc_uid9_fpComplexMulTest_b_1_q, clk => clk, aclr => areset );

    -- expOvf_uid359_bc_uid9_fpComplexMulTest(COMPARE,358)@6
    expOvf_uid359_bc_uid9_fpComplexMulTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000000" & cstAllOWE_uid24_ac_uid6_fpComplexMulTest_q));
    expOvf_uid359_bc_uid9_fpComplexMulTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((13 downto 12 => redist81_expRPreExcExt_uid355_bc_uid9_fpComplexMulTest_b_1_q(11)) & redist81_expRPreExcExt_uid355_bc_uid9_fpComplexMulTest_b_1_q));
    expOvf_uid359_bc_uid9_fpComplexMulTest_o <= STD_LOGIC_VECTOR(SIGNED(expOvf_uid359_bc_uid9_fpComplexMulTest_a) - SIGNED(expOvf_uid359_bc_uid9_fpComplexMulTest_b));
    expOvf_uid359_bc_uid9_fpComplexMulTest_c(0) <= expOvf_uid359_bc_uid9_fpComplexMulTest_o(13);

    -- invExpXIsMax_uid49_ac_uid6_fpComplexMulTest(LOGICAL,48)@6
    invExpXIsMax_uid49_ac_uid6_fpComplexMulTest_q <= not (redist112_expXIsMax_uid44_ac_uid6_fpComplexMulTest_q_2_q);

    -- InvExpXIsZero_uid50_ac_uid6_fpComplexMulTest(LOGICAL,49)@6
    InvExpXIsZero_uid50_ac_uid6_fpComplexMulTest_q <= not (redist113_excZ_y_uid43_ac_uid6_fpComplexMulTest_q_2_q);

    -- excR_y_uid51_ac_uid6_fpComplexMulTest(LOGICAL,50)@6
    excR_y_uid51_ac_uid6_fpComplexMulTest_q <= InvExpXIsZero_uid50_ac_uid6_fpComplexMulTest_q and invExpXIsMax_uid49_ac_uid6_fpComplexMulTest_q;

    -- invExpXIsMax_uid125_bd_uid7_fpComplexMulTest(LOGICAL,124)@6
    invExpXIsMax_uid125_bd_uid7_fpComplexMulTest_q <= not (redist99_expXIsMax_uid120_bd_uid7_fpComplexMulTest_q_2_q);

    -- InvExpXIsZero_uid126_bd_uid7_fpComplexMulTest(LOGICAL,125)@6
    InvExpXIsZero_uid126_bd_uid7_fpComplexMulTest_q <= not (redist100_excZ_x_uid119_bd_uid7_fpComplexMulTest_q_2_q);

    -- excR_x_uid127_bd_uid7_fpComplexMulTest(LOGICAL,126)@6
    excR_x_uid127_bd_uid7_fpComplexMulTest_q <= InvExpXIsZero_uid126_bd_uid7_fpComplexMulTest_q and invExpXIsMax_uid125_bd_uid7_fpComplexMulTest_q;

    -- ExcROvfAndInReg_uid368_bc_uid9_fpComplexMulTest(LOGICAL,367)@6
    ExcROvfAndInReg_uid368_bc_uid9_fpComplexMulTest_q <= excR_x_uid127_bd_uid7_fpComplexMulTest_q and excR_y_uid51_ac_uid6_fpComplexMulTest_q and expOvf_uid359_bc_uid9_fpComplexMulTest_c;

    -- excYRAndExcXI_uid367_bc_uid9_fpComplexMulTest(LOGICAL,366)@6
    excYRAndExcXI_uid367_bc_uid9_fpComplexMulTest_q <= excR_y_uid51_ac_uid6_fpComplexMulTest_q and excI_x_uid123_bd_uid7_fpComplexMulTest_q;

    -- excXRAndExcYI_uid366_bc_uid9_fpComplexMulTest(LOGICAL,365)@6
    excXRAndExcYI_uid366_bc_uid9_fpComplexMulTest_q <= excR_x_uid127_bd_uid7_fpComplexMulTest_q and excI_y_uid47_ac_uid6_fpComplexMulTest_q;

    -- excXIAndExcYI_uid365_bc_uid9_fpComplexMulTest(LOGICAL,364)@6
    excXIAndExcYI_uid365_bc_uid9_fpComplexMulTest_q <= excI_x_uid123_bd_uid7_fpComplexMulTest_q and excI_y_uid47_ac_uid6_fpComplexMulTest_q;

    -- excRInf_uid369_bc_uid9_fpComplexMulTest(LOGICAL,368)@6 + 1
    excRInf_uid369_bc_uid9_fpComplexMulTest_qi <= excXIAndExcYI_uid365_bc_uid9_fpComplexMulTest_q or excXRAndExcYI_uid366_bc_uid9_fpComplexMulTest_q or excYRAndExcXI_uid367_bc_uid9_fpComplexMulTest_q or ExcROvfAndInReg_uid368_bc_uid9_fpComplexMulTest_q;
    excRInf_uid369_bc_uid9_fpComplexMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => excRInf_uid369_bc_uid9_fpComplexMulTest_qi, xout => excRInf_uid369_bc_uid9_fpComplexMulTest_q, clk => clk, aclr => areset );

    -- expUdf_uid357_bc_uid9_fpComplexMulTest_cmp_sign(LOGICAL,779)@6
    expUdf_uid357_bc_uid9_fpComplexMulTest_cmp_sign_q <= STD_LOGIC_VECTOR(redist81_expRPreExcExt_uid355_bc_uid9_fpComplexMulTest_b_1_q(11 downto 11));

    -- excZC3_uid363_bc_uid9_fpComplexMulTest(LOGICAL,362)@6
    excZC3_uid363_bc_uid9_fpComplexMulTest_q <= excR_x_uid127_bd_uid7_fpComplexMulTest_q and excR_y_uid51_ac_uid6_fpComplexMulTest_q and expUdf_uid357_bc_uid9_fpComplexMulTest_cmp_sign_q;

    -- excYZAndExcXR_uid362_bc_uid9_fpComplexMulTest(LOGICAL,361)@6
    excYZAndExcXR_uid362_bc_uid9_fpComplexMulTest_q <= redist113_excZ_y_uid43_ac_uid6_fpComplexMulTest_q_2_q and excR_x_uid127_bd_uid7_fpComplexMulTest_q;

    -- excXZAndExcYR_uid361_bc_uid9_fpComplexMulTest(LOGICAL,360)@6
    excXZAndExcYR_uid361_bc_uid9_fpComplexMulTest_q <= redist100_excZ_x_uid119_bd_uid7_fpComplexMulTest_q_2_q and excR_y_uid51_ac_uid6_fpComplexMulTest_q;

    -- excXZAndExcYZ_uid360_bc_uid9_fpComplexMulTest(LOGICAL,359)@6
    excXZAndExcYZ_uid360_bc_uid9_fpComplexMulTest_q <= redist100_excZ_x_uid119_bd_uid7_fpComplexMulTest_q_2_q and redist113_excZ_y_uid43_ac_uid6_fpComplexMulTest_q_2_q;

    -- excRZero_uid364_bc_uid9_fpComplexMulTest(LOGICAL,363)@6 + 1
    excRZero_uid364_bc_uid9_fpComplexMulTest_qi <= excXZAndExcYZ_uid360_bc_uid9_fpComplexMulTest_q or excXZAndExcYR_uid361_bc_uid9_fpComplexMulTest_q or excYZAndExcXR_uid362_bc_uid9_fpComplexMulTest_q or excZC3_uid363_bc_uid9_fpComplexMulTest_q;
    excRZero_uid364_bc_uid9_fpComplexMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => excRZero_uid364_bc_uid9_fpComplexMulTest_qi, xout => excRZero_uid364_bc_uid9_fpComplexMulTest_q, clk => clk, aclr => areset );

    -- concExc_uid374_bc_uid9_fpComplexMulTest(BITJOIN,373)@7
    concExc_uid374_bc_uid9_fpComplexMulTest_q <= excRNaN_uid373_bc_uid9_fpComplexMulTest_q & excRInf_uid369_bc_uid9_fpComplexMulTest_q & excRZero_uid364_bc_uid9_fpComplexMulTest_q;

    -- excREnc_uid375_bc_uid9_fpComplexMulTest(LOOKUP,374)@7
    excREnc_uid375_bc_uid9_fpComplexMulTest_combproc: PROCESS (concExc_uid374_bc_uid9_fpComplexMulTest_q)
    BEGIN
        -- Begin reserved scope level
        CASE (concExc_uid374_bc_uid9_fpComplexMulTest_q) IS
            WHEN "000" => excREnc_uid375_bc_uid9_fpComplexMulTest_q <= "01";
            WHEN "001" => excREnc_uid375_bc_uid9_fpComplexMulTest_q <= "00";
            WHEN "010" => excREnc_uid375_bc_uid9_fpComplexMulTest_q <= "10";
            WHEN "011" => excREnc_uid375_bc_uid9_fpComplexMulTest_q <= "00";
            WHEN "100" => excREnc_uid375_bc_uid9_fpComplexMulTest_q <= "11";
            WHEN "101" => excREnc_uid375_bc_uid9_fpComplexMulTest_q <= "00";
            WHEN "110" => excREnc_uid375_bc_uid9_fpComplexMulTest_q <= "00";
            WHEN "111" => excREnc_uid375_bc_uid9_fpComplexMulTest_q <= "00";
            WHEN OTHERS => -- unreachable
                           excREnc_uid375_bc_uid9_fpComplexMulTest_q <= (others => '-');
        END CASE;
        -- End reserved scope level
    END PROCESS;

    -- invExcRNaN_uid376_bc_uid9_fpComplexMulTest(LOGICAL,375)@7
    invExcRNaN_uid376_bc_uid9_fpComplexMulTest_q <= not (excRNaN_uid373_bc_uid9_fpComplexMulTest_q);

    -- signY_uid23_ac_uid6_fpComplexMulTest(BITSELECT,22)@0
    signY_uid23_ac_uid6_fpComplexMulTest_b <= STD_LOGIC_VECTOR(c(31 downto 31));

    -- redist117_signY_uid23_ac_uid6_fpComplexMulTest_b_6(DELAY,1198)
    redist117_signY_uid23_ac_uid6_fpComplexMulTest_b_6 : dspba_delay
    GENERIC MAP ( width => 1, depth => 6, reset_kind => "ASYNC" )
    PORT MAP ( xin => signY_uid23_ac_uid6_fpComplexMulTest_b, xout => redist117_signY_uid23_ac_uid6_fpComplexMulTest_b_6_q, clk => clk, aclr => areset );

    -- signX_uid112_bd_uid7_fpComplexMulTest(BITSELECT,111)@0
    signX_uid112_bd_uid7_fpComplexMulTest_b <= STD_LOGIC_VECTOR(b(31 downto 31));

    -- redist102_signX_uid112_bd_uid7_fpComplexMulTest_b_6(DELAY,1183)
    redist102_signX_uid112_bd_uid7_fpComplexMulTest_b_6 : dspba_delay
    GENERIC MAP ( width => 1, depth => 6, reset_kind => "ASYNC" )
    PORT MAP ( xin => signX_uid112_bd_uid7_fpComplexMulTest_b, xout => redist102_signX_uid112_bd_uid7_fpComplexMulTest_b_6_q, clk => clk, aclr => areset );

    -- signR_uid332_bc_uid9_fpComplexMulTest(LOGICAL,331)@6 + 1
    signR_uid332_bc_uid9_fpComplexMulTest_qi <= redist102_signX_uid112_bd_uid7_fpComplexMulTest_b_6_q xor redist117_signY_uid23_ac_uid6_fpComplexMulTest_b_6_q;
    signR_uid332_bc_uid9_fpComplexMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => signR_uid332_bc_uid9_fpComplexMulTest_qi, xout => signR_uid332_bc_uid9_fpComplexMulTest_q, clk => clk, aclr => areset );

    -- signRPostExc_uid377_bc_uid9_fpComplexMulTest(LOGICAL,376)@7
    signRPostExc_uid377_bc_uid9_fpComplexMulTest_q <= signR_uid332_bc_uid9_fpComplexMulTest_q and invExcRNaN_uid376_bc_uid9_fpComplexMulTest_q;

    -- expRPreExc_uid356_bc_uid9_fpComplexMulTest(BITSELECT,355)@6
    expRPreExc_uid356_bc_uid9_fpComplexMulTest_in <= redist81_expRPreExcExt_uid355_bc_uid9_fpComplexMulTest_b_1_q(7 downto 0);
    expRPreExc_uid356_bc_uid9_fpComplexMulTest_b <= expRPreExc_uid356_bc_uid9_fpComplexMulTest_in(7 downto 0);

    -- redist80_expRPreExc_uid356_bc_uid9_fpComplexMulTest_b_1(DELAY,1161)
    redist80_expRPreExc_uid356_bc_uid9_fpComplexMulTest_b_1 : dspba_delay
    GENERIC MAP ( width => 8, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => expRPreExc_uid356_bc_uid9_fpComplexMulTest_b, xout => redist80_expRPreExc_uid356_bc_uid9_fpComplexMulTest_b_1_q, clk => clk, aclr => areset );

    -- fracRPreExc_uid354_bc_uid9_fpComplexMulTest(BITSELECT,353)@5
    fracRPreExc_uid354_bc_uid9_fpComplexMulTest_in <= expFracRPostRounding_uid353_bc_uid9_fpComplexMulTest_q(23 downto 0);
    fracRPreExc_uid354_bc_uid9_fpComplexMulTest_b <= fracRPreExc_uid354_bc_uid9_fpComplexMulTest_in(23 downto 1);

    -- redist82_fracRPreExc_uid354_bc_uid9_fpComplexMulTest_b_2(DELAY,1163)
    redist82_fracRPreExc_uid354_bc_uid9_fpComplexMulTest_b_2 : dspba_delay
    GENERIC MAP ( width => 23, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => fracRPreExc_uid354_bc_uid9_fpComplexMulTest_b, xout => redist82_fracRPreExc_uid354_bc_uid9_fpComplexMulTest_b_2_q, clk => clk, aclr => areset );

    -- R_uid378_bc_uid9_fpComplexMulTest(BITJOIN,377)@7
    R_uid378_bc_uid9_fpComplexMulTest_q <= excREnc_uid375_bc_uid9_fpComplexMulTest_q & signRPostExc_uid377_bc_uid9_fpComplexMulTest_q & redist80_expRPreExc_uid356_bc_uid9_fpComplexMulTest_b_1_q & redist82_fracRPreExc_uid354_bc_uid9_fpComplexMulTest_b_2_q;

    -- sigY_uid576_rImag_uid17_fpComplexMulTest(BITSELECT,575)@7
    sigY_uid576_rImag_uid17_fpComplexMulTest_b <= STD_LOGIC_VECTOR(R_uid378_bc_uid9_fpComplexMulTest_q(31 downto 31));

    -- redist47_sigY_uid576_rImag_uid17_fpComplexMulTest_b_1(DELAY,1128)
    redist47_sigY_uid576_rImag_uid17_fpComplexMulTest_b_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => sigY_uid576_rImag_uid17_fpComplexMulTest_b, xout => redist47_sigY_uid576_rImag_uid17_fpComplexMulTest_b_1_q, clk => clk, aclr => areset );

    -- expY_uid575_rImag_uid17_fpComplexMulTest(BITSELECT,574)@7
    expY_uid575_rImag_uid17_fpComplexMulTest_b <= R_uid378_bc_uid9_fpComplexMulTest_q(30 downto 23);

    -- redist48_expY_uid575_rImag_uid17_fpComplexMulTest_b_1(DELAY,1129)
    redist48_expY_uid575_rImag_uid17_fpComplexMulTest_b_1 : dspba_delay
    GENERIC MAP ( width => 8, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => expY_uid575_rImag_uid17_fpComplexMulTest_b, xout => redist48_expY_uid575_rImag_uid17_fpComplexMulTest_b_1_q, clk => clk, aclr => areset );

    -- fracY_uid574_rImag_uid17_fpComplexMulTest(BITSELECT,573)@7
    fracY_uid574_rImag_uid17_fpComplexMulTest_b <= R_uid378_bc_uid9_fpComplexMulTest_q(22 downto 0);

    -- redist49_fracY_uid574_rImag_uid17_fpComplexMulTest_b_1(DELAY,1130)
    redist49_fracY_uid574_rImag_uid17_fpComplexMulTest_b_1 : dspba_delay
    GENERIC MAP ( width => 23, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => fracY_uid574_rImag_uid17_fpComplexMulTest_b, xout => redist49_fracY_uid574_rImag_uid17_fpComplexMulTest_b_1_q, clk => clk, aclr => areset );

    -- ypn_uid577_rImag_uid17_fpComplexMulTest(BITJOIN,576)@8
    ypn_uid577_rImag_uid17_fpComplexMulTest_q <= redist47_sigY_uid576_rImag_uid17_fpComplexMulTest_b_1_q & redist48_expY_uid575_rImag_uid17_fpComplexMulTest_b_1_q & redist49_fracY_uid574_rImag_uid17_fpComplexMulTest_b_1_q;

    -- frac_x_uid28_ac_uid6_fpComplexMulTest(BITSELECT,27)@0
    frac_x_uid28_ac_uid6_fpComplexMulTest_b <= a(22 downto 0);

    -- fracXIsZero_uid31_ac_uid6_fpComplexMulTest(LOGICAL,30)@0 + 1
    fracXIsZero_uid31_ac_uid6_fpComplexMulTest_qi <= "1" WHEN cstZeroWF_uid25_ac_uid6_fpComplexMulTest_q = frac_x_uid28_ac_uid6_fpComplexMulTest_b ELSE "0";
    fracXIsZero_uid31_ac_uid6_fpComplexMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => fracXIsZero_uid31_ac_uid6_fpComplexMulTest_qi, xout => fracXIsZero_uid31_ac_uid6_fpComplexMulTest_q, clk => clk, aclr => areset );

    -- redist114_fracXIsZero_uid31_ac_uid6_fpComplexMulTest_q_6(DELAY,1195)
    redist114_fracXIsZero_uid31_ac_uid6_fpComplexMulTest_q_6 : dspba_delay
    GENERIC MAP ( width => 1, depth => 5, reset_kind => "ASYNC" )
    PORT MAP ( xin => fracXIsZero_uid31_ac_uid6_fpComplexMulTest_q, xout => redist114_fracXIsZero_uid31_ac_uid6_fpComplexMulTest_q_6_q, clk => clk, aclr => areset );

    -- expX_uid20_ac_uid6_fpComplexMulTest(BITSELECT,19)@0
    expX_uid20_ac_uid6_fpComplexMulTest_b <= a(30 downto 23);

    -- redist120_expX_uid20_ac_uid6_fpComplexMulTest_b_4(DELAY,1201)
    redist120_expX_uid20_ac_uid6_fpComplexMulTest_b_4 : dspba_delay
    GENERIC MAP ( width => 8, depth => 4, reset_kind => "ASYNC" )
    PORT MAP ( xin => expX_uid20_ac_uid6_fpComplexMulTest_b, xout => redist120_expX_uid20_ac_uid6_fpComplexMulTest_b_4_q, clk => clk, aclr => areset );

    -- expXIsMax_uid30_ac_uid6_fpComplexMulTest(LOGICAL,29)@4 + 1
    expXIsMax_uid30_ac_uid6_fpComplexMulTest_qi <= "1" WHEN redist120_expX_uid20_ac_uid6_fpComplexMulTest_b_4_q = cstAllOWE_uid24_ac_uid6_fpComplexMulTest_q ELSE "0";
    expXIsMax_uid30_ac_uid6_fpComplexMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => expXIsMax_uid30_ac_uid6_fpComplexMulTest_qi, xout => expXIsMax_uid30_ac_uid6_fpComplexMulTest_q, clk => clk, aclr => areset );

    -- redist115_expXIsMax_uid30_ac_uid6_fpComplexMulTest_q_2(DELAY,1196)
    redist115_expXIsMax_uid30_ac_uid6_fpComplexMulTest_q_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => expXIsMax_uid30_ac_uid6_fpComplexMulTest_q, xout => redist115_expXIsMax_uid30_ac_uid6_fpComplexMulTest_q_2_q, clk => clk, aclr => areset );

    -- excI_x_uid33_ac_uid6_fpComplexMulTest(LOGICAL,32)@6
    excI_x_uid33_ac_uid6_fpComplexMulTest_q <= redist115_expXIsMax_uid30_ac_uid6_fpComplexMulTest_q_2_q and redist114_fracXIsZero_uid31_ac_uid6_fpComplexMulTest_q_6_q;

    -- expY_uid111_bd_uid7_fpComplexMulTest(BITSELECT,110)@0
    expY_uid111_bd_uid7_fpComplexMulTest_b <= d(30 downto 23);

    -- redist103_expY_uid111_bd_uid7_fpComplexMulTest_b_4(DELAY,1184)
    redist103_expY_uid111_bd_uid7_fpComplexMulTest_b_4 : dspba_delay
    GENERIC MAP ( width => 8, depth => 4, reset_kind => "ASYNC" )
    PORT MAP ( xin => expY_uid111_bd_uid7_fpComplexMulTest_b, xout => redist103_expY_uid111_bd_uid7_fpComplexMulTest_b_4_q, clk => clk, aclr => areset );

    -- excZ_y_uid133_bd_uid7_fpComplexMulTest(LOGICAL,132)@4 + 1
    excZ_y_uid133_bd_uid7_fpComplexMulTest_qi <= "1" WHEN redist103_expY_uid111_bd_uid7_fpComplexMulTest_b_4_q = cstAllZWE_uid26_ac_uid6_fpComplexMulTest_q ELSE "0";
    excZ_y_uid133_bd_uid7_fpComplexMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => excZ_y_uid133_bd_uid7_fpComplexMulTest_qi, xout => excZ_y_uid133_bd_uid7_fpComplexMulTest_q, clk => clk, aclr => areset );

    -- redist97_excZ_y_uid133_bd_uid7_fpComplexMulTest_q_2(DELAY,1178)
    redist97_excZ_y_uid133_bd_uid7_fpComplexMulTest_q_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => excZ_y_uid133_bd_uid7_fpComplexMulTest_q, xout => redist97_excZ_y_uid133_bd_uid7_fpComplexMulTest_q_2_q, clk => clk, aclr => areset );

    -- excYZAndExcXI_uid280_ad_uid8_fpComplexMulTest(LOGICAL,279)@6
    excYZAndExcXI_uid280_ad_uid8_fpComplexMulTest_q <= redist97_excZ_y_uid133_bd_uid7_fpComplexMulTest_q_2_q and excI_x_uid33_ac_uid6_fpComplexMulTest_q;

    -- frac_y_uid132_bd_uid7_fpComplexMulTest(BITSELECT,131)@0
    frac_y_uid132_bd_uid7_fpComplexMulTest_b <= d(22 downto 0);

    -- fracXIsZero_uid135_bd_uid7_fpComplexMulTest(LOGICAL,134)@0 + 1
    fracXIsZero_uid135_bd_uid7_fpComplexMulTest_qi <= "1" WHEN cstZeroWF_uid25_ac_uid6_fpComplexMulTest_q = frac_y_uid132_bd_uid7_fpComplexMulTest_b ELSE "0";
    fracXIsZero_uid135_bd_uid7_fpComplexMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => fracXIsZero_uid135_bd_uid7_fpComplexMulTest_qi, xout => fracXIsZero_uid135_bd_uid7_fpComplexMulTest_q, clk => clk, aclr => areset );

    -- redist95_fracXIsZero_uid135_bd_uid7_fpComplexMulTest_q_6(DELAY,1176)
    redist95_fracXIsZero_uid135_bd_uid7_fpComplexMulTest_q_6 : dspba_delay
    GENERIC MAP ( width => 1, depth => 5, reset_kind => "ASYNC" )
    PORT MAP ( xin => fracXIsZero_uid135_bd_uid7_fpComplexMulTest_q, xout => redist95_fracXIsZero_uid135_bd_uid7_fpComplexMulTest_q_6_q, clk => clk, aclr => areset );

    -- expXIsMax_uid134_bd_uid7_fpComplexMulTest(LOGICAL,133)@4 + 1
    expXIsMax_uid134_bd_uid7_fpComplexMulTest_qi <= "1" WHEN redist103_expY_uid111_bd_uid7_fpComplexMulTest_b_4_q = cstAllOWE_uid24_ac_uid6_fpComplexMulTest_q ELSE "0";
    expXIsMax_uid134_bd_uid7_fpComplexMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => expXIsMax_uid134_bd_uid7_fpComplexMulTest_qi, xout => expXIsMax_uid134_bd_uid7_fpComplexMulTest_q, clk => clk, aclr => areset );

    -- redist96_expXIsMax_uid134_bd_uid7_fpComplexMulTest_q_2(DELAY,1177)
    redist96_expXIsMax_uid134_bd_uid7_fpComplexMulTest_q_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => expXIsMax_uid134_bd_uid7_fpComplexMulTest_q, xout => redist96_expXIsMax_uid134_bd_uid7_fpComplexMulTest_q_2_q, clk => clk, aclr => areset );

    -- excI_y_uid137_bd_uid7_fpComplexMulTest(LOGICAL,136)@6
    excI_y_uid137_bd_uid7_fpComplexMulTest_q <= redist96_expXIsMax_uid134_bd_uid7_fpComplexMulTest_q_2_q and redist95_fracXIsZero_uid135_bd_uid7_fpComplexMulTest_q_6_q;

    -- excZ_x_uid29_ac_uid6_fpComplexMulTest(LOGICAL,28)@4 + 1
    excZ_x_uid29_ac_uid6_fpComplexMulTest_qi <= "1" WHEN redist120_expX_uid20_ac_uid6_fpComplexMulTest_b_4_q = cstAllZWE_uid26_ac_uid6_fpComplexMulTest_q ELSE "0";
    excZ_x_uid29_ac_uid6_fpComplexMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => excZ_x_uid29_ac_uid6_fpComplexMulTest_qi, xout => excZ_x_uid29_ac_uid6_fpComplexMulTest_q, clk => clk, aclr => areset );

    -- redist116_excZ_x_uid29_ac_uid6_fpComplexMulTest_q_2(DELAY,1197)
    redist116_excZ_x_uid29_ac_uid6_fpComplexMulTest_q_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => excZ_x_uid29_ac_uid6_fpComplexMulTest_q, xout => redist116_excZ_x_uid29_ac_uid6_fpComplexMulTest_q_2_q, clk => clk, aclr => areset );

    -- excXZAndExcYI_uid281_ad_uid8_fpComplexMulTest(LOGICAL,280)@6
    excXZAndExcYI_uid281_ad_uid8_fpComplexMulTest_q <= redist116_excZ_x_uid29_ac_uid6_fpComplexMulTest_q_2_q and excI_y_uid137_bd_uid7_fpComplexMulTest_q;

    -- ZeroTimesInf_uid282_ad_uid8_fpComplexMulTest(LOGICAL,281)@6
    ZeroTimesInf_uid282_ad_uid8_fpComplexMulTest_q <= excXZAndExcYI_uid281_ad_uid8_fpComplexMulTest_q or excYZAndExcXI_uid280_ad_uid8_fpComplexMulTest_q;

    -- fracXIsNotZero_uid136_bd_uid7_fpComplexMulTest(LOGICAL,135)@6
    fracXIsNotZero_uid136_bd_uid7_fpComplexMulTest_q <= not (redist95_fracXIsZero_uid135_bd_uid7_fpComplexMulTest_q_6_q);

    -- excN_y_uid138_bd_uid7_fpComplexMulTest(LOGICAL,137)@6
    excN_y_uid138_bd_uid7_fpComplexMulTest_q <= redist96_expXIsMax_uid134_bd_uid7_fpComplexMulTest_q_2_q and fracXIsNotZero_uid136_bd_uid7_fpComplexMulTest_q;

    -- fracXIsNotZero_uid32_ac_uid6_fpComplexMulTest(LOGICAL,31)@6
    fracXIsNotZero_uid32_ac_uid6_fpComplexMulTest_q <= not (redist114_fracXIsZero_uid31_ac_uid6_fpComplexMulTest_q_6_q);

    -- excN_x_uid34_ac_uid6_fpComplexMulTest(LOGICAL,33)@6
    excN_x_uid34_ac_uid6_fpComplexMulTest_q <= redist115_expXIsMax_uid30_ac_uid6_fpComplexMulTest_q_2_q and fracXIsNotZero_uid32_ac_uid6_fpComplexMulTest_q;

    -- excRNaN_uid283_ad_uid8_fpComplexMulTest(LOGICAL,282)@6 + 1
    excRNaN_uid283_ad_uid8_fpComplexMulTest_qi <= excN_x_uid34_ac_uid6_fpComplexMulTest_q or excN_y_uid138_bd_uid7_fpComplexMulTest_q or ZeroTimesInf_uid282_ad_uid8_fpComplexMulTest_q;
    excRNaN_uid283_ad_uid8_fpComplexMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => excRNaN_uid283_ad_uid8_fpComplexMulTest_qi, xout => excRNaN_uid283_ad_uid8_fpComplexMulTest_q, clk => clk, aclr => areset );

    -- ofracX_uid54_ac_uid6_fpComplexMulTest(BITJOIN,53)@0
    ofracX_uid54_ac_uid6_fpComplexMulTest_q <= VCC_q & frac_x_uid28_ac_uid6_fpComplexMulTest_b;

    -- prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_bs1_merged_bit_select(BITSELECT,1059)@0
    prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_bs1_merged_bit_select_b <= ofracX_uid54_ac_uid6_fpComplexMulTest_q(17 downto 0);
    prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_bs1_merged_bit_select_c <= ofracX_uid54_ac_uid6_fpComplexMulTest_q(23 downto 18);

    -- redist13_prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_bs1_merged_bit_select_c_1(DELAY,1094)
    redist13_prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_bs1_merged_bit_select_c_1 : dspba_delay
    GENERIC MAP ( width => 6, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_bs1_merged_bit_select_c, xout => redist13_prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_bs1_merged_bit_select_c_1_q, clk => clk, aclr => areset );

    -- ofracY_uid147_bd_uid7_fpComplexMulTest(BITJOIN,146)@0
    ofracY_uid147_bd_uid7_fpComplexMulTest_q <= VCC_q & frac_y_uid132_bd_uid7_fpComplexMulTest_b;

    -- prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_bs2_merged_bit_select(BITSELECT,1062)@0
    prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_bs2_merged_bit_select_b <= ofracY_uid147_bd_uid7_fpComplexMulTest_q(17 downto 0);
    prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_bs2_merged_bit_select_c <= ofracY_uid147_bd_uid7_fpComplexMulTest_q(23 downto 18);

    -- redist10_prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_bs2_merged_bit_select_b_1(DELAY,1091)
    redist10_prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_bs2_merged_bit_select_b_1 : dspba_delay
    GENERIC MAP ( width => 18, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_bs2_merged_bit_select_b, xout => redist10_prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_bs2_merged_bit_select_b_1_q, clk => clk, aclr => areset );

    -- prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im6(MULT,997)@1 + 2
    prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im6_a0 <= redist10_prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_bs2_merged_bit_select_b_1_q;
    prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im6_b0 <= redist13_prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_bs1_merged_bit_select_c_1_q;
    prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im6_reset <= areset;
    prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im6_component : lpm_mult
    GENERIC MAP (
        lpm_widtha => 18,
        lpm_widthb => 6,
        lpm_widthp => 24,
        lpm_widths => 1,
        lpm_type => "LPM_MULT",
        lpm_representation => "UNSIGNED",
        lpm_hint => "DEDICATED_MULTIPLIER_CIRCUITRY=YES, MAXIMIZE_SPEED=5",
        lpm_pipeline => 2
    )
    PORT MAP (
        dataa => prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im6_a0,
        datab => prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im6_b0,
        clken => VCC_q(0),
        aclr => prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im6_reset,
        clock => clk,
        result => prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im6_s1
    );
    prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im6_q <= prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im6_s1;

    -- prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_align_15(BITSHIFT,1006)@3
    prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_align_15_qint <= prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im6_q & "000000000000000000";
    prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_align_15_q <= prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_align_15_qint(41 downto 0);

    -- prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im3(MULT,994)@0 + 2
    prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im3_a0 <= prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_bs1_merged_bit_select_b;
    prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im3_b0 <= prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_bs2_merged_bit_select_c;
    prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im3_reset <= areset;
    prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im3_component : lpm_mult
    GENERIC MAP (
        lpm_widtha => 18,
        lpm_widthb => 6,
        lpm_widthp => 24,
        lpm_widths => 1,
        lpm_type => "LPM_MULT",
        lpm_representation => "UNSIGNED",
        lpm_hint => "DEDICATED_MULTIPLIER_CIRCUITRY=YES, MAXIMIZE_SPEED=5",
        lpm_pipeline => 2
    )
    PORT MAP (
        dataa => prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im3_a0,
        datab => prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im3_b0,
        clken => VCC_q(0),
        aclr => prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im3_reset,
        clock => clk,
        result => prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im3_s1
    );
    prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im3_q <= prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im3_s1;

    -- prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_align_13(BITSHIFT,1004)@2
    prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_align_13_qint <= prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im3_q & "000000000000000000";
    prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_align_13_q <= prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_align_13_qint(41 downto 0);

    -- prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im9(MULT,1000)@0 + 2
    prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im9_a0 <= prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_bs1_merged_bit_select_c;
    prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im9_b0 <= prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_bs2_merged_bit_select_c;
    prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im9_reset <= areset;
    prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im9_component : lpm_mult
    GENERIC MAP (
        lpm_widtha => 6,
        lpm_widthb => 6,
        lpm_widthp => 12,
        lpm_widths => 1,
        lpm_type => "LPM_MULT",
        lpm_representation => "UNSIGNED",
        lpm_hint => "DEDICATED_MULTIPLIER_CIRCUITRY=YES, MAXIMIZE_SPEED=5",
        lpm_pipeline => 2
    )
    PORT MAP (
        dataa => prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im9_a0,
        datab => prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im9_b0,
        clken => VCC_q(0),
        aclr => prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im9_reset,
        clock => clk,
        result => prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im9_s1
    );
    prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im9_q <= prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im9_s1;

    -- prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im0(MULT,991)@0 + 2
    prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im0_a0 <= prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_bs1_merged_bit_select_b;
    prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im0_b0 <= prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_bs2_merged_bit_select_b;
    prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im0_reset <= areset;
    prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im0_component : lpm_mult
    GENERIC MAP (
        lpm_widtha => 18,
        lpm_widthb => 18,
        lpm_widthp => 36,
        lpm_widths => 1,
        lpm_type => "LPM_MULT",
        lpm_representation => "UNSIGNED",
        lpm_hint => "DEDICATED_MULTIPLIER_CIRCUITRY=YES, MAXIMIZE_SPEED=5",
        lpm_pipeline => 2
    )
    PORT MAP (
        dataa => prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im0_a0,
        datab => prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im0_b0,
        clken => VCC_q(0),
        aclr => prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im0_reset,
        clock => clk,
        result => prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im0_s1
    );
    prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im0_q <= prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im0_s1;

    -- prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_join_12(BITJOIN,1003)@2
    prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_join_12_q <= prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im9_q & prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_im0_q;

    -- prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_result_add_0_0(ADD,1008)@2 + 1
    prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_result_add_0_0_a <= STD_LOGIC_VECTOR("0" & prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_join_12_q);
    prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_result_add_0_0_b <= STD_LOGIC_VECTOR("0000000" & prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_align_13_q);
    prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_result_add_0_0_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_result_add_0_0_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_result_add_0_0_o <= STD_LOGIC_VECTOR(UNSIGNED(prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_result_add_0_0_a) + UNSIGNED(prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_result_add_0_0_b));
        END IF;
    END PROCESS;
    prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_result_add_0_0_q <= prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_result_add_0_0_o(48 downto 0);

    -- prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_result_add_1_0(ADD,1009)@3
    prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_result_add_1_0_a <= STD_LOGIC_VECTOR("0" & prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_result_add_0_0_q);
    prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_result_add_1_0_b <= STD_LOGIC_VECTOR("00000000" & prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_align_15_q);
    prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_result_add_1_0_o <= STD_LOGIC_VECTOR(UNSIGNED(prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_result_add_1_0_a) + UNSIGNED(prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_result_add_1_0_b));
    prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_result_add_1_0_q <= prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_result_add_1_0_o(49 downto 0);

    -- osig_uid707_prod_uid241_ad_uid8_fpComplexMulTest(BITSELECT,706)@3
    osig_uid707_prod_uid241_ad_uid8_fpComplexMulTest_in <= prodXY_uid706_prod_uid241_ad_uid8_fpComplexMulTest_result_add_1_0_q(47 downto 0);
    osig_uid707_prod_uid241_ad_uid8_fpComplexMulTest_b <= osig_uid707_prod_uid241_ad_uid8_fpComplexMulTest_in(47 downto 0);

    -- redist23_osig_uid707_prod_uid241_ad_uid8_fpComplexMulTest_b_1(DELAY,1104)
    redist23_osig_uid707_prod_uid241_ad_uid8_fpComplexMulTest_b_1 : dspba_delay
    GENERIC MAP ( width => 48, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => osig_uid707_prod_uid241_ad_uid8_fpComplexMulTest_b, xout => redist23_osig_uid707_prod_uid241_ad_uid8_fpComplexMulTest_b_1_q, clk => clk, aclr => areset );

    -- normalizeBit_uid243_ad_uid8_fpComplexMulTest(BITSELECT,242)@4
    normalizeBit_uid243_ad_uid8_fpComplexMulTest_b <= STD_LOGIC_VECTOR(redist23_osig_uid707_prod_uid241_ad_uid8_fpComplexMulTest_b_1_q(47 downto 47));

    -- redist89_normalizeBit_uid243_ad_uid8_fpComplexMulTest_b_1(DELAY,1170)
    redist89_normalizeBit_uid243_ad_uid8_fpComplexMulTest_b_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => normalizeBit_uid243_ad_uid8_fpComplexMulTest_b, xout => redist89_normalizeBit_uid243_ad_uid8_fpComplexMulTest_b_1_q, clk => clk, aclr => areset );

    -- fracRPostNormHigh_uid245_ad_uid8_fpComplexMulTest(BITSELECT,244)@4
    fracRPostNormHigh_uid245_ad_uid8_fpComplexMulTest_in <= redist23_osig_uid707_prod_uid241_ad_uid8_fpComplexMulTest_b_1_q(46 downto 0);
    fracRPostNormHigh_uid245_ad_uid8_fpComplexMulTest_b <= fracRPostNormHigh_uid245_ad_uid8_fpComplexMulTest_in(46 downto 23);

    -- fracRPostNormLow_uid246_ad_uid8_fpComplexMulTest(BITSELECT,245)@4
    fracRPostNormLow_uid246_ad_uid8_fpComplexMulTest_in <= redist23_osig_uid707_prod_uid241_ad_uid8_fpComplexMulTest_b_1_q(45 downto 0);
    fracRPostNormLow_uid246_ad_uid8_fpComplexMulTest_b <= fracRPostNormLow_uid246_ad_uid8_fpComplexMulTest_in(45 downto 22);

    -- fracRPostNorm_uid247_ad_uid8_fpComplexMulTest(MUX,246)@4
    fracRPostNorm_uid247_ad_uid8_fpComplexMulTest_s <= normalizeBit_uid243_ad_uid8_fpComplexMulTest_b;
    fracRPostNorm_uid247_ad_uid8_fpComplexMulTest_combproc: PROCESS (fracRPostNorm_uid247_ad_uid8_fpComplexMulTest_s, fracRPostNormLow_uid246_ad_uid8_fpComplexMulTest_b, fracRPostNormHigh_uid245_ad_uid8_fpComplexMulTest_b)
    BEGIN
        CASE (fracRPostNorm_uid247_ad_uid8_fpComplexMulTest_s) IS
            WHEN "0" => fracRPostNorm_uid247_ad_uid8_fpComplexMulTest_q <= fracRPostNormLow_uid246_ad_uid8_fpComplexMulTest_b;
            WHEN "1" => fracRPostNorm_uid247_ad_uid8_fpComplexMulTest_q <= fracRPostNormHigh_uid245_ad_uid8_fpComplexMulTest_b;
            WHEN OTHERS => fracRPostNorm_uid247_ad_uid8_fpComplexMulTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- fracRPostNorm1dto0_uid255_ad_uid8_fpComplexMulTest(BITSELECT,254)@4
    fracRPostNorm1dto0_uid255_ad_uid8_fpComplexMulTest_in <= fracRPostNorm_uid247_ad_uid8_fpComplexMulTest_q(1 downto 0);
    fracRPostNorm1dto0_uid255_ad_uid8_fpComplexMulTest_b <= fracRPostNorm1dto0_uid255_ad_uid8_fpComplexMulTest_in(1 downto 0);

    -- extraStickyBitOfProd_uid249_ad_uid8_fpComplexMulTest(BITSELECT,248)@4
    extraStickyBitOfProd_uid249_ad_uid8_fpComplexMulTest_in <= STD_LOGIC_VECTOR(redist23_osig_uid707_prod_uid241_ad_uid8_fpComplexMulTest_b_1_q(22 downto 0));
    extraStickyBitOfProd_uid249_ad_uid8_fpComplexMulTest_b <= STD_LOGIC_VECTOR(extraStickyBitOfProd_uid249_ad_uid8_fpComplexMulTest_in(22 downto 22));

    -- extraStickyBit_uid250_ad_uid8_fpComplexMulTest(MUX,249)@4
    extraStickyBit_uid250_ad_uid8_fpComplexMulTest_s <= normalizeBit_uid243_ad_uid8_fpComplexMulTest_b;
    extraStickyBit_uid250_ad_uid8_fpComplexMulTest_combproc: PROCESS (extraStickyBit_uid250_ad_uid8_fpComplexMulTest_s, GND_q, extraStickyBitOfProd_uid249_ad_uid8_fpComplexMulTest_b)
    BEGIN
        CASE (extraStickyBit_uid250_ad_uid8_fpComplexMulTest_s) IS
            WHEN "0" => extraStickyBit_uid250_ad_uid8_fpComplexMulTest_q <= GND_q;
            WHEN "1" => extraStickyBit_uid250_ad_uid8_fpComplexMulTest_q <= extraStickyBitOfProd_uid249_ad_uid8_fpComplexMulTest_b;
            WHEN OTHERS => extraStickyBit_uid250_ad_uid8_fpComplexMulTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- stickyRange_uid248_ad_uid8_fpComplexMulTest(BITSELECT,247)@4
    stickyRange_uid248_ad_uid8_fpComplexMulTest_in <= redist23_osig_uid707_prod_uid241_ad_uid8_fpComplexMulTest_b_1_q(21 downto 0);
    stickyRange_uid248_ad_uid8_fpComplexMulTest_b <= stickyRange_uid248_ad_uid8_fpComplexMulTest_in(21 downto 0);

    -- stickyExtendedRange_uid251_ad_uid8_fpComplexMulTest(BITJOIN,250)@4
    stickyExtendedRange_uid251_ad_uid8_fpComplexMulTest_q <= extraStickyBit_uid250_ad_uid8_fpComplexMulTest_q & stickyRange_uid248_ad_uid8_fpComplexMulTest_b;

    -- stickyRangeComparator_uid253_ad_uid8_fpComplexMulTest(LOGICAL,252)@4
    stickyRangeComparator_uid253_ad_uid8_fpComplexMulTest_q <= "1" WHEN stickyExtendedRange_uid251_ad_uid8_fpComplexMulTest_q = cstZeroWF_uid25_ac_uid6_fpComplexMulTest_q ELSE "0";

    -- sticky_uid254_ad_uid8_fpComplexMulTest(LOGICAL,253)@4
    sticky_uid254_ad_uid8_fpComplexMulTest_q <= not (stickyRangeComparator_uid253_ad_uid8_fpComplexMulTest_q);

    -- lrs_uid256_ad_uid8_fpComplexMulTest(BITJOIN,255)@4
    lrs_uid256_ad_uid8_fpComplexMulTest_q <= fracRPostNorm1dto0_uid255_ad_uid8_fpComplexMulTest_b & sticky_uid254_ad_uid8_fpComplexMulTest_q;

    -- roundBitDetectionPattern_uid258_ad_uid8_fpComplexMulTest(LOGICAL,257)@4 + 1
    roundBitDetectionPattern_uid258_ad_uid8_fpComplexMulTest_qi <= "1" WHEN lrs_uid256_ad_uid8_fpComplexMulTest_q = roundBitDetectionConstant_uid77_ac_uid6_fpComplexMulTest_q ELSE "0";
    roundBitDetectionPattern_uid258_ad_uid8_fpComplexMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => roundBitDetectionPattern_uid258_ad_uid8_fpComplexMulTest_qi, xout => roundBitDetectionPattern_uid258_ad_uid8_fpComplexMulTest_q, clk => clk, aclr => areset );

    -- roundBit_uid259_ad_uid8_fpComplexMulTest(LOGICAL,258)@5
    roundBit_uid259_ad_uid8_fpComplexMulTest_q <= not (roundBitDetectionPattern_uid258_ad_uid8_fpComplexMulTest_q);

    -- roundBitAndNormalizationOp_uid262_ad_uid8_fpComplexMulTest(BITJOIN,261)@5
    roundBitAndNormalizationOp_uid262_ad_uid8_fpComplexMulTest_q <= GND_q & redist89_normalizeBit_uid243_ad_uid8_fpComplexMulTest_b_1_q & cstZeroWF_uid25_ac_uid6_fpComplexMulTest_q & roundBit_uid259_ad_uid8_fpComplexMulTest_q;

    -- expSum_uid238_ad_uid8_fpComplexMulTest(ADD,237)@4
    expSum_uid238_ad_uid8_fpComplexMulTest_a <= STD_LOGIC_VECTOR("0" & redist120_expX_uid20_ac_uid6_fpComplexMulTest_b_4_q);
    expSum_uid238_ad_uid8_fpComplexMulTest_b <= STD_LOGIC_VECTOR("0" & redist103_expY_uid111_bd_uid7_fpComplexMulTest_b_4_q);
    expSum_uid238_ad_uid8_fpComplexMulTest_o <= STD_LOGIC_VECTOR(UNSIGNED(expSum_uid238_ad_uid8_fpComplexMulTest_a) + UNSIGNED(expSum_uid238_ad_uid8_fpComplexMulTest_b));
    expSum_uid238_ad_uid8_fpComplexMulTest_q <= expSum_uid238_ad_uid8_fpComplexMulTest_o(8 downto 0);

    -- expSumMBias_uid240_ad_uid8_fpComplexMulTest(SUB,239)@4 + 1
    expSumMBias_uid240_ad_uid8_fpComplexMulTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & expSum_uid238_ad_uid8_fpComplexMulTest_q));
    expSumMBias_uid240_ad_uid8_fpComplexMulTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((11 downto 10 => biasInc_uid59_ac_uid6_fpComplexMulTest_q(9)) & biasInc_uid59_ac_uid6_fpComplexMulTest_q));
    expSumMBias_uid240_ad_uid8_fpComplexMulTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            expSumMBias_uid240_ad_uid8_fpComplexMulTest_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            expSumMBias_uid240_ad_uid8_fpComplexMulTest_o <= STD_LOGIC_VECTOR(SIGNED(expSumMBias_uid240_ad_uid8_fpComplexMulTest_a) - SIGNED(expSumMBias_uid240_ad_uid8_fpComplexMulTest_b));
        END IF;
    END PROCESS;
    expSumMBias_uid240_ad_uid8_fpComplexMulTest_q <= expSumMBias_uid240_ad_uid8_fpComplexMulTest_o(10 downto 0);

    -- redist88_fracRPostNorm_uid247_ad_uid8_fpComplexMulTest_q_1(DELAY,1169)
    redist88_fracRPostNorm_uid247_ad_uid8_fpComplexMulTest_q_1 : dspba_delay
    GENERIC MAP ( width => 24, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => fracRPostNorm_uid247_ad_uid8_fpComplexMulTest_q, xout => redist88_fracRPostNorm_uid247_ad_uid8_fpComplexMulTest_q_1_q, clk => clk, aclr => areset );

    -- expFracPreRound_uid260_ad_uid8_fpComplexMulTest(BITJOIN,259)@5
    expFracPreRound_uid260_ad_uid8_fpComplexMulTest_q <= expSumMBias_uid240_ad_uid8_fpComplexMulTest_q & redist88_fracRPostNorm_uid247_ad_uid8_fpComplexMulTest_q_1_q;

    -- expFracRPostRounding_uid263_ad_uid8_fpComplexMulTest(ADD,262)@5
    expFracRPostRounding_uid263_ad_uid8_fpComplexMulTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((36 downto 35 => expFracPreRound_uid260_ad_uid8_fpComplexMulTest_q(34)) & expFracPreRound_uid260_ad_uid8_fpComplexMulTest_q));
    expFracRPostRounding_uid263_ad_uid8_fpComplexMulTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("00000000000" & roundBitAndNormalizationOp_uid262_ad_uid8_fpComplexMulTest_q));
    expFracRPostRounding_uid263_ad_uid8_fpComplexMulTest_o <= STD_LOGIC_VECTOR(SIGNED(expFracRPostRounding_uid263_ad_uid8_fpComplexMulTest_a) + SIGNED(expFracRPostRounding_uid263_ad_uid8_fpComplexMulTest_b));
    expFracRPostRounding_uid263_ad_uid8_fpComplexMulTest_q <= expFracRPostRounding_uid263_ad_uid8_fpComplexMulTest_o(35 downto 0);

    -- expRPreExcExt_uid265_ad_uid8_fpComplexMulTest(BITSELECT,264)@5
    expRPreExcExt_uid265_ad_uid8_fpComplexMulTest_b <= STD_LOGIC_VECTOR(expFracRPostRounding_uid263_ad_uid8_fpComplexMulTest_q(35 downto 24));

    -- redist86_expRPreExcExt_uid265_ad_uid8_fpComplexMulTest_b_1(DELAY,1167)
    redist86_expRPreExcExt_uid265_ad_uid8_fpComplexMulTest_b_1 : dspba_delay
    GENERIC MAP ( width => 12, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => expRPreExcExt_uid265_ad_uid8_fpComplexMulTest_b, xout => redist86_expRPreExcExt_uid265_ad_uid8_fpComplexMulTest_b_1_q, clk => clk, aclr => areset );

    -- expOvf_uid269_ad_uid8_fpComplexMulTest(COMPARE,268)@6
    expOvf_uid269_ad_uid8_fpComplexMulTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000000" & cstAllOWE_uid24_ac_uid6_fpComplexMulTest_q));
    expOvf_uid269_ad_uid8_fpComplexMulTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((13 downto 12 => redist86_expRPreExcExt_uid265_ad_uid8_fpComplexMulTest_b_1_q(11)) & redist86_expRPreExcExt_uid265_ad_uid8_fpComplexMulTest_b_1_q));
    expOvf_uid269_ad_uid8_fpComplexMulTest_o <= STD_LOGIC_VECTOR(SIGNED(expOvf_uid269_ad_uid8_fpComplexMulTest_a) - SIGNED(expOvf_uid269_ad_uid8_fpComplexMulTest_b));
    expOvf_uid269_ad_uid8_fpComplexMulTest_c(0) <= expOvf_uid269_ad_uid8_fpComplexMulTest_o(13);

    -- invExpXIsMax_uid139_bd_uid7_fpComplexMulTest(LOGICAL,138)@6
    invExpXIsMax_uid139_bd_uid7_fpComplexMulTest_q <= not (redist96_expXIsMax_uid134_bd_uid7_fpComplexMulTest_q_2_q);

    -- InvExpXIsZero_uid140_bd_uid7_fpComplexMulTest(LOGICAL,139)@6
    InvExpXIsZero_uid140_bd_uid7_fpComplexMulTest_q <= not (redist97_excZ_y_uid133_bd_uid7_fpComplexMulTest_q_2_q);

    -- excR_y_uid141_bd_uid7_fpComplexMulTest(LOGICAL,140)@6
    excR_y_uid141_bd_uid7_fpComplexMulTest_q <= InvExpXIsZero_uid140_bd_uid7_fpComplexMulTest_q and invExpXIsMax_uid139_bd_uid7_fpComplexMulTest_q;

    -- invExpXIsMax_uid35_ac_uid6_fpComplexMulTest(LOGICAL,34)@6
    invExpXIsMax_uid35_ac_uid6_fpComplexMulTest_q <= not (redist115_expXIsMax_uid30_ac_uid6_fpComplexMulTest_q_2_q);

    -- InvExpXIsZero_uid36_ac_uid6_fpComplexMulTest(LOGICAL,35)@6
    InvExpXIsZero_uid36_ac_uid6_fpComplexMulTest_q <= not (redist116_excZ_x_uid29_ac_uid6_fpComplexMulTest_q_2_q);

    -- excR_x_uid37_ac_uid6_fpComplexMulTest(LOGICAL,36)@6
    excR_x_uid37_ac_uid6_fpComplexMulTest_q <= InvExpXIsZero_uid36_ac_uid6_fpComplexMulTest_q and invExpXIsMax_uid35_ac_uid6_fpComplexMulTest_q;

    -- ExcROvfAndInReg_uid278_ad_uid8_fpComplexMulTest(LOGICAL,277)@6
    ExcROvfAndInReg_uid278_ad_uid8_fpComplexMulTest_q <= excR_x_uid37_ac_uid6_fpComplexMulTest_q and excR_y_uid141_bd_uid7_fpComplexMulTest_q and expOvf_uid269_ad_uid8_fpComplexMulTest_c;

    -- excYRAndExcXI_uid277_ad_uid8_fpComplexMulTest(LOGICAL,276)@6
    excYRAndExcXI_uid277_ad_uid8_fpComplexMulTest_q <= excR_y_uid141_bd_uid7_fpComplexMulTest_q and excI_x_uid33_ac_uid6_fpComplexMulTest_q;

    -- excXRAndExcYI_uid276_ad_uid8_fpComplexMulTest(LOGICAL,275)@6
    excXRAndExcYI_uid276_ad_uid8_fpComplexMulTest_q <= excR_x_uid37_ac_uid6_fpComplexMulTest_q and excI_y_uid137_bd_uid7_fpComplexMulTest_q;

    -- excXIAndExcYI_uid275_ad_uid8_fpComplexMulTest(LOGICAL,274)@6
    excXIAndExcYI_uid275_ad_uid8_fpComplexMulTest_q <= excI_x_uid33_ac_uid6_fpComplexMulTest_q and excI_y_uid137_bd_uid7_fpComplexMulTest_q;

    -- excRInf_uid279_ad_uid8_fpComplexMulTest(LOGICAL,278)@6 + 1
    excRInf_uid279_ad_uid8_fpComplexMulTest_qi <= excXIAndExcYI_uid275_ad_uid8_fpComplexMulTest_q or excXRAndExcYI_uid276_ad_uid8_fpComplexMulTest_q or excYRAndExcXI_uid277_ad_uid8_fpComplexMulTest_q or ExcROvfAndInReg_uid278_ad_uid8_fpComplexMulTest_q;
    excRInf_uid279_ad_uid8_fpComplexMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => excRInf_uid279_ad_uid8_fpComplexMulTest_qi, xout => excRInf_uid279_ad_uid8_fpComplexMulTest_q, clk => clk, aclr => areset );

    -- expUdf_uid267_ad_uid8_fpComplexMulTest_cmp_sign(LOGICAL,777)@6
    expUdf_uid267_ad_uid8_fpComplexMulTest_cmp_sign_q <= STD_LOGIC_VECTOR(redist86_expRPreExcExt_uid265_ad_uid8_fpComplexMulTest_b_1_q(11 downto 11));

    -- excZC3_uid273_ad_uid8_fpComplexMulTest(LOGICAL,272)@6
    excZC3_uid273_ad_uid8_fpComplexMulTest_q <= excR_x_uid37_ac_uid6_fpComplexMulTest_q and excR_y_uid141_bd_uid7_fpComplexMulTest_q and expUdf_uid267_ad_uid8_fpComplexMulTest_cmp_sign_q;

    -- excYZAndExcXR_uid272_ad_uid8_fpComplexMulTest(LOGICAL,271)@6
    excYZAndExcXR_uid272_ad_uid8_fpComplexMulTest_q <= redist97_excZ_y_uid133_bd_uid7_fpComplexMulTest_q_2_q and excR_x_uid37_ac_uid6_fpComplexMulTest_q;

    -- excXZAndExcYR_uid271_ad_uid8_fpComplexMulTest(LOGICAL,270)@6
    excXZAndExcYR_uid271_ad_uid8_fpComplexMulTest_q <= redist116_excZ_x_uid29_ac_uid6_fpComplexMulTest_q_2_q and excR_y_uid141_bd_uid7_fpComplexMulTest_q;

    -- excXZAndExcYZ_uid270_ad_uid8_fpComplexMulTest(LOGICAL,269)@6
    excXZAndExcYZ_uid270_ad_uid8_fpComplexMulTest_q <= redist116_excZ_x_uid29_ac_uid6_fpComplexMulTest_q_2_q and redist97_excZ_y_uid133_bd_uid7_fpComplexMulTest_q_2_q;

    -- excRZero_uid274_ad_uid8_fpComplexMulTest(LOGICAL,273)@6 + 1
    excRZero_uid274_ad_uid8_fpComplexMulTest_qi <= excXZAndExcYZ_uid270_ad_uid8_fpComplexMulTest_q or excXZAndExcYR_uid271_ad_uid8_fpComplexMulTest_q or excYZAndExcXR_uid272_ad_uid8_fpComplexMulTest_q or excZC3_uid273_ad_uid8_fpComplexMulTest_q;
    excRZero_uid274_ad_uid8_fpComplexMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => excRZero_uid274_ad_uid8_fpComplexMulTest_qi, xout => excRZero_uid274_ad_uid8_fpComplexMulTest_q, clk => clk, aclr => areset );

    -- concExc_uid284_ad_uid8_fpComplexMulTest(BITJOIN,283)@7
    concExc_uid284_ad_uid8_fpComplexMulTest_q <= excRNaN_uid283_ad_uid8_fpComplexMulTest_q & excRInf_uid279_ad_uid8_fpComplexMulTest_q & excRZero_uid274_ad_uid8_fpComplexMulTest_q;

    -- excREnc_uid285_ad_uid8_fpComplexMulTest(LOOKUP,284)@7
    excREnc_uid285_ad_uid8_fpComplexMulTest_combproc: PROCESS (concExc_uid284_ad_uid8_fpComplexMulTest_q)
    BEGIN
        -- Begin reserved scope level
        CASE (concExc_uid284_ad_uid8_fpComplexMulTest_q) IS
            WHEN "000" => excREnc_uid285_ad_uid8_fpComplexMulTest_q <= "01";
            WHEN "001" => excREnc_uid285_ad_uid8_fpComplexMulTest_q <= "00";
            WHEN "010" => excREnc_uid285_ad_uid8_fpComplexMulTest_q <= "10";
            WHEN "011" => excREnc_uid285_ad_uid8_fpComplexMulTest_q <= "00";
            WHEN "100" => excREnc_uid285_ad_uid8_fpComplexMulTest_q <= "11";
            WHEN "101" => excREnc_uid285_ad_uid8_fpComplexMulTest_q <= "00";
            WHEN "110" => excREnc_uid285_ad_uid8_fpComplexMulTest_q <= "00";
            WHEN "111" => excREnc_uid285_ad_uid8_fpComplexMulTest_q <= "00";
            WHEN OTHERS => -- unreachable
                           excREnc_uid285_ad_uid8_fpComplexMulTest_q <= (others => '-');
        END CASE;
        -- End reserved scope level
    END PROCESS;

    -- invExcRNaN_uid286_ad_uid8_fpComplexMulTest(LOGICAL,285)@7
    invExcRNaN_uid286_ad_uid8_fpComplexMulTest_q <= not (excRNaN_uid283_ad_uid8_fpComplexMulTest_q);

    -- signY_uid113_bd_uid7_fpComplexMulTest(BITSELECT,112)@0
    signY_uid113_bd_uid7_fpComplexMulTest_b <= STD_LOGIC_VECTOR(d(31 downto 31));

    -- redist101_signY_uid113_bd_uid7_fpComplexMulTest_b_6(DELAY,1182)
    redist101_signY_uid113_bd_uid7_fpComplexMulTest_b_6 : dspba_delay
    GENERIC MAP ( width => 1, depth => 6, reset_kind => "ASYNC" )
    PORT MAP ( xin => signY_uid113_bd_uid7_fpComplexMulTest_b, xout => redist101_signY_uid113_bd_uid7_fpComplexMulTest_b_6_q, clk => clk, aclr => areset );

    -- signX_uid22_ac_uid6_fpComplexMulTest(BITSELECT,21)@0
    signX_uid22_ac_uid6_fpComplexMulTest_b <= STD_LOGIC_VECTOR(a(31 downto 31));

    -- redist118_signX_uid22_ac_uid6_fpComplexMulTest_b_6(DELAY,1199)
    redist118_signX_uid22_ac_uid6_fpComplexMulTest_b_6 : dspba_delay
    GENERIC MAP ( width => 1, depth => 6, reset_kind => "ASYNC" )
    PORT MAP ( xin => signX_uid22_ac_uid6_fpComplexMulTest_b, xout => redist118_signX_uid22_ac_uid6_fpComplexMulTest_b_6_q, clk => clk, aclr => areset );

    -- signR_uid242_ad_uid8_fpComplexMulTest(LOGICAL,241)@6 + 1
    signR_uid242_ad_uid8_fpComplexMulTest_qi <= redist118_signX_uid22_ac_uid6_fpComplexMulTest_b_6_q xor redist101_signY_uid113_bd_uid7_fpComplexMulTest_b_6_q;
    signR_uid242_ad_uid8_fpComplexMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => signR_uid242_ad_uid8_fpComplexMulTest_qi, xout => signR_uid242_ad_uid8_fpComplexMulTest_q, clk => clk, aclr => areset );

    -- signRPostExc_uid287_ad_uid8_fpComplexMulTest(LOGICAL,286)@7
    signRPostExc_uid287_ad_uid8_fpComplexMulTest_q <= signR_uid242_ad_uid8_fpComplexMulTest_q and invExcRNaN_uid286_ad_uid8_fpComplexMulTest_q;

    -- expRPreExc_uid266_ad_uid8_fpComplexMulTest(BITSELECT,265)@6
    expRPreExc_uid266_ad_uid8_fpComplexMulTest_in <= redist86_expRPreExcExt_uid265_ad_uid8_fpComplexMulTest_b_1_q(7 downto 0);
    expRPreExc_uid266_ad_uid8_fpComplexMulTest_b <= expRPreExc_uid266_ad_uid8_fpComplexMulTest_in(7 downto 0);

    -- redist85_expRPreExc_uid266_ad_uid8_fpComplexMulTest_b_1(DELAY,1166)
    redist85_expRPreExc_uid266_ad_uid8_fpComplexMulTest_b_1 : dspba_delay
    GENERIC MAP ( width => 8, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => expRPreExc_uid266_ad_uid8_fpComplexMulTest_b, xout => redist85_expRPreExc_uid266_ad_uid8_fpComplexMulTest_b_1_q, clk => clk, aclr => areset );

    -- fracRPreExc_uid264_ad_uid8_fpComplexMulTest(BITSELECT,263)@5
    fracRPreExc_uid264_ad_uid8_fpComplexMulTest_in <= expFracRPostRounding_uid263_ad_uid8_fpComplexMulTest_q(23 downto 0);
    fracRPreExc_uid264_ad_uid8_fpComplexMulTest_b <= fracRPreExc_uid264_ad_uid8_fpComplexMulTest_in(23 downto 1);

    -- redist87_fracRPreExc_uid264_ad_uid8_fpComplexMulTest_b_2(DELAY,1168)
    redist87_fracRPreExc_uid264_ad_uid8_fpComplexMulTest_b_2 : dspba_delay
    GENERIC MAP ( width => 23, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => fracRPreExc_uid264_ad_uid8_fpComplexMulTest_b, xout => redist87_fracRPreExc_uid264_ad_uid8_fpComplexMulTest_b_2_q, clk => clk, aclr => areset );

    -- R_uid288_ad_uid8_fpComplexMulTest(BITJOIN,287)@7
    R_uid288_ad_uid8_fpComplexMulTest_q <= excREnc_uid285_ad_uid8_fpComplexMulTest_q & signRPostExc_uid287_ad_uid8_fpComplexMulTest_q & redist85_expRPreExc_uid266_ad_uid8_fpComplexMulTest_b_1_q & redist87_fracRPreExc_uid264_ad_uid8_fpComplexMulTest_b_2_q;

    -- redist84_R_uid288_ad_uid8_fpComplexMulTest_q_1(DELAY,1165)
    redist84_R_uid288_ad_uid8_fpComplexMulTest_q_1 : dspba_delay
    GENERIC MAP ( width => 34, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => R_uid288_ad_uid8_fpComplexMulTest_q, xout => redist84_R_uid288_ad_uid8_fpComplexMulTest_q_1_q, clk => clk, aclr => areset );

    -- xMuxRange_uid579_rImag_uid17_fpComplexMulTest(BITSELECT,578)@8
    xMuxRange_uid579_rImag_uid17_fpComplexMulTest_in <= redist84_R_uid288_ad_uid8_fpComplexMulTest_q_1_q(31 downto 0);
    xMuxRange_uid579_rImag_uid17_fpComplexMulTest_b <= xMuxRange_uid579_rImag_uid17_fpComplexMulTest_in(31 downto 0);

    -- expFracY_uid569_rImag_uid17_fpComplexMulTest(BITSELECT,568)@7
    expFracY_uid569_rImag_uid17_fpComplexMulTest_b <= R_uid378_bc_uid9_fpComplexMulTest_q(30 downto 0);

    -- expFracX_uid568_rImag_uid17_fpComplexMulTest(BITSELECT,567)@7
    expFracX_uid568_rImag_uid17_fpComplexMulTest_b <= R_uid288_ad_uid8_fpComplexMulTest_q(30 downto 0);

    -- xGTEy_uid570_rImag_uid17_fpComplexMulTest(COMPARE,569)@7 + 1
    xGTEy_uid570_rImag_uid17_fpComplexMulTest_a <= STD_LOGIC_VECTOR("00" & expFracX_uid568_rImag_uid17_fpComplexMulTest_b);
    xGTEy_uid570_rImag_uid17_fpComplexMulTest_b <= STD_LOGIC_VECTOR("00" & expFracY_uid569_rImag_uid17_fpComplexMulTest_b);
    xGTEy_uid570_rImag_uid17_fpComplexMulTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            xGTEy_uid570_rImag_uid17_fpComplexMulTest_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            xGTEy_uid570_rImag_uid17_fpComplexMulTest_o <= STD_LOGIC_VECTOR(UNSIGNED(xGTEy_uid570_rImag_uid17_fpComplexMulTest_a) - UNSIGNED(xGTEy_uid570_rImag_uid17_fpComplexMulTest_b));
        END IF;
    END PROCESS;
    xGTEy_uid570_rImag_uid17_fpComplexMulTest_n(0) <= not (xGTEy_uid570_rImag_uid17_fpComplexMulTest_o(32));

    -- zero2b_uid386_rReal_uid16_fpComplexMulTest(CONSTANT,385)
    zero2b_uid386_rReal_uid16_fpComplexMulTest_q <= "00";

    -- excX_uid559_rImag_uid17_fpComplexMulTest(BITSELECT,558)@7
    excX_uid559_rImag_uid17_fpComplexMulTest_b <= R_uid378_bc_uid9_fpComplexMulTest_q(33 downto 32);

    -- excXZero_uid564_rImag_uid17_fpComplexMulTest(LOGICAL,563)@7 + 1
    excXZero_uid564_rImag_uid17_fpComplexMulTest_qi <= "1" WHEN excX_uid559_rImag_uid17_fpComplexMulTest_b = zero2b_uid386_rReal_uid16_fpComplexMulTest_q ELSE "0";
    excXZero_uid564_rImag_uid17_fpComplexMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => excXZero_uid564_rImag_uid17_fpComplexMulTest_qi, xout => excXZero_uid564_rImag_uid17_fpComplexMulTest_q, clk => clk, aclr => areset );

    -- xGTEyOrYz_uid571_rImag_uid17_fpComplexMulTest(LOGICAL,570)@8
    xGTEyOrYz_uid571_rImag_uid17_fpComplexMulTest_q <= excXZero_uid564_rImag_uid17_fpComplexMulTest_q or xGTEy_uid570_rImag_uid17_fpComplexMulTest_n;

    -- excX_uid545_rImag_uid17_fpComplexMulTest(BITSELECT,544)@8
    excX_uid545_rImag_uid17_fpComplexMulTest_b <= redist84_R_uid288_ad_uid8_fpComplexMulTest_q_1_q(33 downto 32);

    -- excXZero_uid550_rImag_uid17_fpComplexMulTest(LOGICAL,549)@8
    excXZero_uid550_rImag_uid17_fpComplexMulTest_q <= "1" WHEN excX_uid545_rImag_uid17_fpComplexMulTest_b = zero2b_uid386_rReal_uid16_fpComplexMulTest_q ELSE "0";

    -- invExcXZ_uid572_rImag_uid17_fpComplexMulTest(LOGICAL,571)@8
    invExcXZ_uid572_rImag_uid17_fpComplexMulTest_q <= not (excXZero_uid550_rImag_uid17_fpComplexMulTest_q);

    -- xGTEy_uid573_rImag_uid17_fpComplexMulTest(LOGICAL,572)@8
    xGTEy_uid573_rImag_uid17_fpComplexMulTest_q <= invExcXZ_uid572_rImag_uid17_fpComplexMulTest_q and xGTEyOrYz_uid571_rImag_uid17_fpComplexMulTest_q;

    -- bSig_uid582_rImag_uid17_fpComplexMulTest(MUX,581)@8
    bSig_uid582_rImag_uid17_fpComplexMulTest_s <= xGTEy_uid573_rImag_uid17_fpComplexMulTest_q;
    bSig_uid582_rImag_uid17_fpComplexMulTest_combproc: PROCESS (bSig_uid582_rImag_uid17_fpComplexMulTest_s, xMuxRange_uid579_rImag_uid17_fpComplexMulTest_b, ypn_uid577_rImag_uid17_fpComplexMulTest_q)
    BEGIN
        CASE (bSig_uid582_rImag_uid17_fpComplexMulTest_s) IS
            WHEN "0" => bSig_uid582_rImag_uid17_fpComplexMulTest_q <= xMuxRange_uid579_rImag_uid17_fpComplexMulTest_b;
            WHEN "1" => bSig_uid582_rImag_uid17_fpComplexMulTest_q <= ypn_uid577_rImag_uid17_fpComplexMulTest_q;
            WHEN OTHERS => bSig_uid582_rImag_uid17_fpComplexMulTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- sigB_uid596_rImag_uid17_fpComplexMulTest(BITSELECT,595)@8
    sigB_uid596_rImag_uid17_fpComplexMulTest_b <= STD_LOGIC_VECTOR(bSig_uid582_rImag_uid17_fpComplexMulTest_q(31 downto 31));

    -- redist35_sigB_uid596_rImag_uid17_fpComplexMulTest_b_3(DELAY,1116)
    redist35_sigB_uid596_rImag_uid17_fpComplexMulTest_b_3 : dspba_delay
    GENERIC MAP ( width => 1, depth => 3, reset_kind => "ASYNC" )
    PORT MAP ( xin => sigB_uid596_rImag_uid17_fpComplexMulTest_b, xout => redist35_sigB_uid596_rImag_uid17_fpComplexMulTest_b_3_q, clk => clk, aclr => areset );

    -- aSig_uid581_rImag_uid17_fpComplexMulTest(MUX,580)@8
    aSig_uid581_rImag_uid17_fpComplexMulTest_s <= xGTEy_uid573_rImag_uid17_fpComplexMulTest_q;
    aSig_uid581_rImag_uid17_fpComplexMulTest_combproc: PROCESS (aSig_uid581_rImag_uid17_fpComplexMulTest_s, ypn_uid577_rImag_uid17_fpComplexMulTest_q, xMuxRange_uid579_rImag_uid17_fpComplexMulTest_b)
    BEGIN
        CASE (aSig_uid581_rImag_uid17_fpComplexMulTest_s) IS
            WHEN "0" => aSig_uid581_rImag_uid17_fpComplexMulTest_q <= ypn_uid577_rImag_uid17_fpComplexMulTest_q;
            WHEN "1" => aSig_uid581_rImag_uid17_fpComplexMulTest_q <= xMuxRange_uid579_rImag_uid17_fpComplexMulTest_b;
            WHEN OTHERS => aSig_uid581_rImag_uid17_fpComplexMulTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- sigA_uid595_rImag_uid17_fpComplexMulTest(BITSELECT,594)@8
    sigA_uid595_rImag_uid17_fpComplexMulTest_b <= STD_LOGIC_VECTOR(aSig_uid581_rImag_uid17_fpComplexMulTest_q(31 downto 31));

    -- redist37_sigA_uid595_rImag_uid17_fpComplexMulTest_b_3(DELAY,1118)
    redist37_sigA_uid595_rImag_uid17_fpComplexMulTest_b_3 : dspba_delay
    GENERIC MAP ( width => 1, depth => 3, reset_kind => "ASYNC" )
    PORT MAP ( xin => sigA_uid595_rImag_uid17_fpComplexMulTest_b, xout => redist37_sigA_uid595_rImag_uid17_fpComplexMulTest_b_3_q, clk => clk, aclr => areset );

    -- effSub_uid597_rImag_uid17_fpComplexMulTest(LOGICAL,596)@11
    effSub_uid597_rImag_uid17_fpComplexMulTest_q <= redist37_sigA_uid595_rImag_uid17_fpComplexMulTest_b_3_q xor redist35_sigB_uid596_rImag_uid17_fpComplexMulTest_b_3_q;

    -- excBZ_uid590_rImag_uid17_fpComplexMulTest(MUX,589)@8
    excBZ_uid590_rImag_uid17_fpComplexMulTest_s <= xGTEy_uid573_rImag_uid17_fpComplexMulTest_q;
    excBZ_uid590_rImag_uid17_fpComplexMulTest_combproc: PROCESS (excBZ_uid590_rImag_uid17_fpComplexMulTest_s, excXZero_uid550_rImag_uid17_fpComplexMulTest_q, excXZero_uid564_rImag_uid17_fpComplexMulTest_q)
    BEGIN
        CASE (excBZ_uid590_rImag_uid17_fpComplexMulTest_s) IS
            WHEN "0" => excBZ_uid590_rImag_uid17_fpComplexMulTest_q <= excXZero_uid550_rImag_uid17_fpComplexMulTest_q;
            WHEN "1" => excBZ_uid590_rImag_uid17_fpComplexMulTest_q <= excXZero_uid564_rImag_uid17_fpComplexMulTest_q;
            WHEN OTHERS => excBZ_uid590_rImag_uid17_fpComplexMulTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- expB_uid592_rImag_uid17_fpComplexMulTest(BITSELECT,591)@8
    expB_uid592_rImag_uid17_fpComplexMulTest_in <= bSig_uid582_rImag_uid17_fpComplexMulTest_q(30 downto 0);
    expB_uid592_rImag_uid17_fpComplexMulTest_b <= expB_uid592_rImag_uid17_fpComplexMulTest_in(30 downto 23);

    -- expA_uid591_rImag_uid17_fpComplexMulTest(BITSELECT,590)@8
    expA_uid591_rImag_uid17_fpComplexMulTest_in <= aSig_uid581_rImag_uid17_fpComplexMulTest_q(30 downto 0);
    expA_uid591_rImag_uid17_fpComplexMulTest_b <= expA_uid591_rImag_uid17_fpComplexMulTest_in(30 downto 23);

    -- expAmExpB_uid607_rImag_uid17_fpComplexMulTest(SUB,606)@8 + 1
    expAmExpB_uid607_rImag_uid17_fpComplexMulTest_a <= STD_LOGIC_VECTOR("0" & expA_uid591_rImag_uid17_fpComplexMulTest_b);
    expAmExpB_uid607_rImag_uid17_fpComplexMulTest_b <= STD_LOGIC_VECTOR("0" & expB_uid592_rImag_uid17_fpComplexMulTest_b);
    expAmExpB_uid607_rImag_uid17_fpComplexMulTest_i <= expAmExpB_uid607_rImag_uid17_fpComplexMulTest_a;
    expAmExpB_uid607_rImag_uid17_fpComplexMulTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            expAmExpB_uid607_rImag_uid17_fpComplexMulTest_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (excBZ_uid590_rImag_uid17_fpComplexMulTest_q = "1") THEN
                expAmExpB_uid607_rImag_uid17_fpComplexMulTest_o <= expAmExpB_uid607_rImag_uid17_fpComplexMulTest_i;
            ELSE
                expAmExpB_uid607_rImag_uid17_fpComplexMulTest_o <= STD_LOGIC_VECTOR(UNSIGNED(expAmExpB_uid607_rImag_uid17_fpComplexMulTest_a) - UNSIGNED(expAmExpB_uid607_rImag_uid17_fpComplexMulTest_b));
            END IF;
        END IF;
    END PROCESS;
    expAmExpB_uid607_rImag_uid17_fpComplexMulTest_q <= expAmExpB_uid607_rImag_uid17_fpComplexMulTest_o(8 downto 0);

    -- cWFP2_uid448_rReal_uid16_fpComplexMulTest(CONSTANT,447)
    cWFP2_uid448_rReal_uid16_fpComplexMulTest_q <= "11001";

    -- shiftedOut_uid610_rImag_uid17_fpComplexMulTest(COMPARE,609)@9 + 1
    shiftedOut_uid610_rImag_uid17_fpComplexMulTest_a <= STD_LOGIC_VECTOR("000000" & cWFP2_uid448_rReal_uid16_fpComplexMulTest_q);
    shiftedOut_uid610_rImag_uid17_fpComplexMulTest_b <= STD_LOGIC_VECTOR("00" & expAmExpB_uid607_rImag_uid17_fpComplexMulTest_q);
    shiftedOut_uid610_rImag_uid17_fpComplexMulTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            shiftedOut_uid610_rImag_uid17_fpComplexMulTest_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            shiftedOut_uid610_rImag_uid17_fpComplexMulTest_o <= STD_LOGIC_VECTOR(UNSIGNED(shiftedOut_uid610_rImag_uid17_fpComplexMulTest_a) - UNSIGNED(shiftedOut_uid610_rImag_uid17_fpComplexMulTest_b));
        END IF;
    END PROCESS;
    shiftedOut_uid610_rImag_uid17_fpComplexMulTest_c(0) <= shiftedOut_uid610_rImag_uid17_fpComplexMulTest_o(10);

    -- iShiftedOut_uid614_rImag_uid17_fpComplexMulTest(LOGICAL,613)@10
    iShiftedOut_uid614_rImag_uid17_fpComplexMulTest_q <= not (shiftedOut_uid610_rImag_uid17_fpComplexMulTest_c);

    -- rightShiftStage0Idx7_uid804_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest(CONSTANT,803)
    rightShiftStage0Idx7_uid804_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q <= "0000000000000000000000000000000000000000000000000";

    -- rightShiftStage1Idx7Pad7_uid826_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest(CONSTANT,825)
    rightShiftStage1Idx7Pad7_uid826_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q <= "0000000";

    -- rightShiftStage0Idx6Pad48_uid802_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest(CONSTANT,801)
    rightShiftStage0Idx6Pad48_uid802_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q <= "000000000000000000000000000000000000000000000000";

    -- redist42_excBZ_uid590_rImag_uid17_fpComplexMulTest_q_1(DELAY,1123)
    redist42_excBZ_uid590_rImag_uid17_fpComplexMulTest_q_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => excBZ_uid590_rImag_uid17_fpComplexMulTest_q, xout => redist42_excBZ_uid590_rImag_uid17_fpComplexMulTest_q_1_q, clk => clk, aclr => areset );

    -- invExcBZ_uid605_rImag_uid17_fpComplexMulTest(LOGICAL,604)@9
    invExcBZ_uid605_rImag_uid17_fpComplexMulTest_q <= not (redist42_excBZ_uid590_rImag_uid17_fpComplexMulTest_q_1_q);

    -- fracB_uid594_rImag_uid17_fpComplexMulTest(BITSELECT,593)@8
    fracB_uid594_rImag_uid17_fpComplexMulTest_in <= bSig_uid582_rImag_uid17_fpComplexMulTest_q(22 downto 0);
    fracB_uid594_rImag_uid17_fpComplexMulTest_b <= fracB_uid594_rImag_uid17_fpComplexMulTest_in(22 downto 0);

    -- redist39_fracB_uid594_rImag_uid17_fpComplexMulTest_b_1(DELAY,1120)
    redist39_fracB_uid594_rImag_uid17_fpComplexMulTest_b_1 : dspba_delay
    GENERIC MAP ( width => 23, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => fracB_uid594_rImag_uid17_fpComplexMulTest_b, xout => redist39_fracB_uid594_rImag_uid17_fpComplexMulTest_b_1_q, clk => clk, aclr => areset );

    -- fracBz_uid603_rImag_uid17_fpComplexMulTest(MUX,602)@9
    fracBz_uid603_rImag_uid17_fpComplexMulTest_s <= redist42_excBZ_uid590_rImag_uid17_fpComplexMulTest_q_1_q;
    fracBz_uid603_rImag_uid17_fpComplexMulTest_combproc: PROCESS (fracBz_uid603_rImag_uid17_fpComplexMulTest_s, redist39_fracB_uid594_rImag_uid17_fpComplexMulTest_b_1_q, cstZeroWF_uid25_ac_uid6_fpComplexMulTest_q)
    BEGIN
        CASE (fracBz_uid603_rImag_uid17_fpComplexMulTest_s) IS
            WHEN "0" => fracBz_uid603_rImag_uid17_fpComplexMulTest_q <= redist39_fracB_uid594_rImag_uid17_fpComplexMulTest_b_1_q;
            WHEN "1" => fracBz_uid603_rImag_uid17_fpComplexMulTest_q <= cstZeroWF_uid25_ac_uid6_fpComplexMulTest_q;
            WHEN OTHERS => fracBz_uid603_rImag_uid17_fpComplexMulTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- oFracB_uid606_rImag_uid17_fpComplexMulTest(BITJOIN,605)@9
    oFracB_uid606_rImag_uid17_fpComplexMulTest_q <= invExcBZ_uid605_rImag_uid17_fpComplexMulTest_q & fracBz_uid603_rImag_uid17_fpComplexMulTest_q;

    -- padConst_uid451_rReal_uid16_fpComplexMulTest(CONSTANT,450)
    padConst_uid451_rReal_uid16_fpComplexMulTest_q <= "0000000000000000000000000";

    -- rightPaddedIn_uid612_rImag_uid17_fpComplexMulTest(BITJOIN,611)@9
    rightPaddedIn_uid612_rImag_uid17_fpComplexMulTest_q <= oFracB_uid606_rImag_uid17_fpComplexMulTest_q & padConst_uid451_rReal_uid16_fpComplexMulTest_q;

    -- rightShiftStage0Idx6Rng48_uid887_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest(BITSELECT,886)@9
    rightShiftStage0Idx6Rng48_uid887_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_b <= rightPaddedIn_uid612_rImag_uid17_fpComplexMulTest_q(48 downto 48);

    -- rightShiftStage0Idx6_uid889_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest(BITJOIN,888)@9
    rightShiftStage0Idx6_uid889_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_q <= rightShiftStage0Idx6Pad48_uid802_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q & rightShiftStage0Idx6Rng48_uid887_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_b;

    -- rightShiftStage0Idx5Pad40_uid799_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest(CONSTANT,798)
    rightShiftStage0Idx5Pad40_uid799_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q <= "0000000000000000000000000000000000000000";

    -- rightShiftStage0Idx5Rng40_uid884_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest(BITSELECT,883)@9
    rightShiftStage0Idx5Rng40_uid884_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_b <= rightPaddedIn_uid612_rImag_uid17_fpComplexMulTest_q(48 downto 40);

    -- rightShiftStage0Idx5_uid886_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest(BITJOIN,885)@9
    rightShiftStage0Idx5_uid886_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_q <= rightShiftStage0Idx5Pad40_uid799_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q & rightShiftStage0Idx5Rng40_uid884_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_b;

    -- rightShiftStage0Idx4Pad32_uid796_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest(CONSTANT,795)
    rightShiftStage0Idx4Pad32_uid796_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q <= "00000000000000000000000000000000";

    -- rightShiftStage0Idx4Rng32_uid881_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest(BITSELECT,880)@9
    rightShiftStage0Idx4Rng32_uid881_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_b <= rightPaddedIn_uid612_rImag_uid17_fpComplexMulTest_q(48 downto 32);

    -- rightShiftStage0Idx4_uid883_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest(BITJOIN,882)@9
    rightShiftStage0Idx4_uid883_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_q <= rightShiftStage0Idx4Pad32_uid796_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q & rightShiftStage0Idx4Rng32_uid881_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_b;

    -- rightShiftStage0_uid892_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_msplit_1(MUX,1047)@9
    rightShiftStage0_uid892_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_msplit_1_s <= rightShiftStage0_uid892_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_selLSBs_merged_bit_select_b;
    rightShiftStage0_uid892_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_msplit_1_combproc: PROCESS (rightShiftStage0_uid892_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_msplit_1_s, rightShiftStage0Idx4_uid883_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_q, rightShiftStage0Idx5_uid886_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_q, rightShiftStage0Idx6_uid889_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_q, rightShiftStage0Idx7_uid804_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q)
    BEGIN
        CASE (rightShiftStage0_uid892_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_msplit_1_s) IS
            WHEN "00" => rightShiftStage0_uid892_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_msplit_1_q <= rightShiftStage0Idx4_uid883_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_q;
            WHEN "01" => rightShiftStage0_uid892_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_msplit_1_q <= rightShiftStage0Idx5_uid886_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_q;
            WHEN "10" => rightShiftStage0_uid892_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_msplit_1_q <= rightShiftStage0Idx6_uid889_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_q;
            WHEN "11" => rightShiftStage0_uid892_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_msplit_1_q <= rightShiftStage0Idx7_uid804_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q;
            WHEN OTHERS => rightShiftStage0_uid892_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_msplit_1_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rightShiftStage0Idx3Pad24_uid793_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest(CONSTANT,792)
    rightShiftStage0Idx3Pad24_uid793_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q <= "000000000000000000000000";

    -- rightShiftStage0Idx3Rng24_uid878_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest(BITSELECT,877)@9
    rightShiftStage0Idx3Rng24_uid878_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_b <= rightPaddedIn_uid612_rImag_uid17_fpComplexMulTest_q(48 downto 24);

    -- rightShiftStage0Idx3_uid880_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest(BITJOIN,879)@9
    rightShiftStage0Idx3_uid880_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_q <= rightShiftStage0Idx3Pad24_uid793_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q & rightShiftStage0Idx3Rng24_uid878_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_b;

    -- rightShiftStage0Idx2Rng16_uid875_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest(BITSELECT,874)@9
    rightShiftStage0Idx2Rng16_uid875_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_b <= rightPaddedIn_uid612_rImag_uid17_fpComplexMulTest_q(48 downto 16);

    -- rightShiftStage0Idx2_uid877_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest(BITJOIN,876)@9
    rightShiftStage0Idx2_uid877_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_q <= zs_uid712_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q & rightShiftStage0Idx2Rng16_uid875_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_b;

    -- rightShiftStage0Idx1Rng8_uid872_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest(BITSELECT,871)@9
    rightShiftStage0Idx1Rng8_uid872_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_b <= rightPaddedIn_uid612_rImag_uid17_fpComplexMulTest_q(48 downto 8);

    -- rightShiftStage0Idx1_uid874_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest(BITJOIN,873)@9
    rightShiftStage0Idx1_uid874_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_q <= cstAllZWE_uid26_ac_uid6_fpComplexMulTest_q & rightShiftStage0Idx1Rng8_uid872_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_b;

    -- rightShiftStage0_uid892_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_msplit_0(MUX,1046)@9
    rightShiftStage0_uid892_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_msplit_0_s <= rightShiftStage0_uid892_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_selLSBs_merged_bit_select_b;
    rightShiftStage0_uid892_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_msplit_0_combproc: PROCESS (rightShiftStage0_uid892_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_msplit_0_s, rightPaddedIn_uid612_rImag_uid17_fpComplexMulTest_q, rightShiftStage0Idx1_uid874_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_q, rightShiftStage0Idx2_uid877_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_q, rightShiftStage0Idx3_uid880_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_q)
    BEGIN
        CASE (rightShiftStage0_uid892_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_msplit_0_s) IS
            WHEN "00" => rightShiftStage0_uid892_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_msplit_0_q <= rightPaddedIn_uid612_rImag_uid17_fpComplexMulTest_q;
            WHEN "01" => rightShiftStage0_uid892_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_msplit_0_q <= rightShiftStage0Idx1_uid874_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_q;
            WHEN "10" => rightShiftStage0_uid892_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_msplit_0_q <= rightShiftStage0Idx2_uid877_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_q;
            WHEN "11" => rightShiftStage0_uid892_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_msplit_0_q <= rightShiftStage0Idx3_uid880_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_q;
            WHEN OTHERS => rightShiftStage0_uid892_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_msplit_0_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rightShiftStageSel5Dto3_uid891_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_merged_bit_select(BITSELECT,1065)@9
    rightShiftStageSel5Dto3_uid891_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_merged_bit_select_in <= expAmExpB_uid607_rImag_uid17_fpComplexMulTest_q(5 downto 0);
    rightShiftStageSel5Dto3_uid891_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_merged_bit_select_b <= rightShiftStageSel5Dto3_uid891_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_merged_bit_select_in(5 downto 3);
    rightShiftStageSel5Dto3_uid891_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_merged_bit_select_c <= rightShiftStageSel5Dto3_uid891_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_merged_bit_select_in(2 downto 0);

    -- rightShiftStage0_uid892_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_selLSBs_merged_bit_select(BITSELECT,1077)@9
    rightShiftStage0_uid892_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_selLSBs_merged_bit_select_b <= rightShiftStageSel5Dto3_uid891_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_merged_bit_select_b(1 downto 0);
    rightShiftStage0_uid892_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_selLSBs_merged_bit_select_c <= rightShiftStageSel5Dto3_uid891_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_merged_bit_select_b(2 downto 2);

    -- rightShiftStage0_uid892_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_mfinal(MUX,1048)@9 + 1
    rightShiftStage0_uid892_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_mfinal_s <= rightShiftStage0_uid892_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_selLSBs_merged_bit_select_c;
    rightShiftStage0_uid892_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_mfinal_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            rightShiftStage0_uid892_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_mfinal_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            CASE (rightShiftStage0_uid892_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_mfinal_s) IS
                WHEN "0" => rightShiftStage0_uid892_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_mfinal_q <= rightShiftStage0_uid892_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_msplit_0_q;
                WHEN "1" => rightShiftStage0_uid892_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_mfinal_q <= rightShiftStage0_uid892_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_msplit_1_q;
                WHEN OTHERS => rightShiftStage0_uid892_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_mfinal_q <= (others => '0');
            END CASE;
        END IF;
    END PROCESS;

    -- rightShiftStage1Idx7Rng7_uid911_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest(BITSELECT,910)@10
    rightShiftStage1Idx7Rng7_uid911_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_b <= rightShiftStage0_uid892_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_mfinal_q(48 downto 7);

    -- rightShiftStage1Idx7_uid913_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest(BITJOIN,912)@10
    rightShiftStage1Idx7_uid913_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_q <= rightShiftStage1Idx7Pad7_uid826_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q & rightShiftStage1Idx7Rng7_uid911_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_b;

    -- rightShiftStage1Idx6Pad6_uid823_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest(CONSTANT,822)
    rightShiftStage1Idx6Pad6_uid823_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q <= "000000";

    -- rightShiftStage1Idx6Rng6_uid908_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest(BITSELECT,907)@10
    rightShiftStage1Idx6Rng6_uid908_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_b <= rightShiftStage0_uid892_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_mfinal_q(48 downto 6);

    -- rightShiftStage1Idx6_uid910_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest(BITJOIN,909)@10
    rightShiftStage1Idx6_uid910_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_q <= rightShiftStage1Idx6Pad6_uid823_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q & rightShiftStage1Idx6Rng6_uid908_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_b;

    -- rightShiftStage1Idx5Pad5_uid820_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest(CONSTANT,819)
    rightShiftStage1Idx5Pad5_uid820_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q <= "00000";

    -- rightShiftStage1Idx5Rng5_uid905_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest(BITSELECT,904)@10
    rightShiftStage1Idx5Rng5_uid905_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_b <= rightShiftStage0_uid892_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_mfinal_q(48 downto 5);

    -- rightShiftStage1Idx5_uid907_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest(BITJOIN,906)@10
    rightShiftStage1Idx5_uid907_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_q <= rightShiftStage1Idx5Pad5_uid820_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q & rightShiftStage1Idx5Rng5_uid905_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_b;

    -- zs_uid726_lzCountVal_uid472_rReal_uid16_fpComplexMulTest(CONSTANT,725)
    zs_uid726_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q <= "0000";

    -- rightShiftStage1Idx4Rng4_uid902_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest(BITSELECT,901)@10
    rightShiftStage1Idx4Rng4_uid902_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_b <= rightShiftStage0_uid892_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_mfinal_q(48 downto 4);

    -- rightShiftStage1Idx4_uid904_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest(BITJOIN,903)@10
    rightShiftStage1Idx4_uid904_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_q <= zs_uid726_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q & rightShiftStage1Idx4Rng4_uid902_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_b;

    -- rightShiftStage1_uid915_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_msplit_1(MUX,1052)@10
    rightShiftStage1_uid915_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_msplit_1_s <= rightShiftStage1_uid915_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_selLSBs_merged_bit_select_b;
    rightShiftStage1_uid915_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_msplit_1_combproc: PROCESS (rightShiftStage1_uid915_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_msplit_1_s, rightShiftStage1Idx4_uid904_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_q, rightShiftStage1Idx5_uid907_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_q, rightShiftStage1Idx6_uid910_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_q, rightShiftStage1Idx7_uid913_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_q)
    BEGIN
        CASE (rightShiftStage1_uid915_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_msplit_1_s) IS
            WHEN "00" => rightShiftStage1_uid915_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_msplit_1_q <= rightShiftStage1Idx4_uid904_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_q;
            WHEN "01" => rightShiftStage1_uid915_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_msplit_1_q <= rightShiftStage1Idx5_uid907_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_q;
            WHEN "10" => rightShiftStage1_uid915_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_msplit_1_q <= rightShiftStage1Idx6_uid910_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_q;
            WHEN "11" => rightShiftStage1_uid915_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_msplit_1_q <= rightShiftStage1Idx7_uid913_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_q;
            WHEN OTHERS => rightShiftStage1_uid915_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_msplit_1_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rightShiftStage1Idx3Pad3_uid814_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest(CONSTANT,813)
    rightShiftStage1Idx3Pad3_uid814_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q <= "000";

    -- rightShiftStage1Idx3Rng3_uid899_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest(BITSELECT,898)@10
    rightShiftStage1Idx3Rng3_uid899_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_b <= rightShiftStage0_uid892_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_mfinal_q(48 downto 3);

    -- rightShiftStage1Idx3_uid901_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest(BITJOIN,900)@10
    rightShiftStage1Idx3_uid901_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_q <= rightShiftStage1Idx3Pad3_uid814_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q & rightShiftStage1Idx3Rng3_uid899_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_b;

    -- rightShiftStage1Idx2Rng2_uid896_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest(BITSELECT,895)@10
    rightShiftStage1Idx2Rng2_uid896_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_b <= rightShiftStage0_uid892_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_mfinal_q(48 downto 2);

    -- rightShiftStage1Idx2_uid898_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest(BITJOIN,897)@10
    rightShiftStage1Idx2_uid898_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_q <= zero2b_uid386_rReal_uid16_fpComplexMulTest_q & rightShiftStage1Idx2Rng2_uid896_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_b;

    -- rightShiftStage1Idx1Rng1_uid893_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest(BITSELECT,892)@10
    rightShiftStage1Idx1Rng1_uid893_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_b <= rightShiftStage0_uid892_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_mfinal_q(48 downto 1);

    -- rightShiftStage1Idx1_uid895_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest(BITJOIN,894)@10
    rightShiftStage1Idx1_uid895_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_q <= GND_q & rightShiftStage1Idx1Rng1_uid893_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_b;

    -- rightShiftStage1_uid915_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_msplit_0(MUX,1051)@10
    rightShiftStage1_uid915_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_msplit_0_s <= rightShiftStage1_uid915_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_selLSBs_merged_bit_select_b;
    rightShiftStage1_uid915_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_msplit_0_combproc: PROCESS (rightShiftStage1_uid915_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_msplit_0_s, rightShiftStage0_uid892_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_mfinal_q, rightShiftStage1Idx1_uid895_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_q, rightShiftStage1Idx2_uid898_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_q, rightShiftStage1Idx3_uid901_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_q)
    BEGIN
        CASE (rightShiftStage1_uid915_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_msplit_0_s) IS
            WHEN "00" => rightShiftStage1_uid915_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_msplit_0_q <= rightShiftStage0_uid892_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_mfinal_q;
            WHEN "01" => rightShiftStage1_uid915_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_msplit_0_q <= rightShiftStage1Idx1_uid895_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_q;
            WHEN "10" => rightShiftStage1_uid915_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_msplit_0_q <= rightShiftStage1Idx2_uid898_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_q;
            WHEN "11" => rightShiftStage1_uid915_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_msplit_0_q <= rightShiftStage1Idx3_uid901_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_q;
            WHEN OTHERS => rightShiftStage1_uid915_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_msplit_0_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist8_rightShiftStageSel5Dto3_uid891_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_merged_bit_select_c_1(DELAY,1089)
    redist8_rightShiftStageSel5Dto3_uid891_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_merged_bit_select_c_1 : dspba_delay
    GENERIC MAP ( width => 3, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => rightShiftStageSel5Dto3_uid891_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_merged_bit_select_c, xout => redist8_rightShiftStageSel5Dto3_uid891_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_merged_bit_select_c_1_q, clk => clk, aclr => areset );

    -- rightShiftStage1_uid915_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_selLSBs_merged_bit_select(BITSELECT,1078)@10
    rightShiftStage1_uid915_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_selLSBs_merged_bit_select_b <= redist8_rightShiftStageSel5Dto3_uid891_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_merged_bit_select_c_1_q(1 downto 0);
    rightShiftStage1_uid915_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_selLSBs_merged_bit_select_c <= redist8_rightShiftStageSel5Dto3_uid891_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_merged_bit_select_c_1_q(2 downto 2);

    -- rightShiftStage1_uid915_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_mfinal(MUX,1053)@10
    rightShiftStage1_uid915_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_mfinal_s <= rightShiftStage1_uid915_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_selLSBs_merged_bit_select_c;
    rightShiftStage1_uid915_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_mfinal_combproc: PROCESS (rightShiftStage1_uid915_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_mfinal_s, rightShiftStage1_uid915_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_msplit_0_q, rightShiftStage1_uid915_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_msplit_1_q)
    BEGIN
        CASE (rightShiftStage1_uid915_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_mfinal_s) IS
            WHEN "0" => rightShiftStage1_uid915_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_mfinal_q <= rightShiftStage1_uid915_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_msplit_0_q;
            WHEN "1" => rightShiftStage1_uid915_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_mfinal_q <= rightShiftStage1_uid915_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_msplit_1_q;
            WHEN OTHERS => rightShiftStage1_uid915_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_mfinal_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- wIntCst_uid784_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest(CONSTANT,783)
    wIntCst_uid784_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q <= "110001";

    -- shiftedOut_uid871_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest(COMPARE,870)@9 + 1
    shiftedOut_uid871_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_a <= STD_LOGIC_VECTOR("00" & expAmExpB_uid607_rImag_uid17_fpComplexMulTest_q);
    shiftedOut_uid871_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_b <= STD_LOGIC_VECTOR("00000" & wIntCst_uid784_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q);
    shiftedOut_uid871_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            shiftedOut_uid871_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            shiftedOut_uid871_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_o <= STD_LOGIC_VECTOR(UNSIGNED(shiftedOut_uid871_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_a) - UNSIGNED(shiftedOut_uid871_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_b));
        END IF;
    END PROCESS;
    shiftedOut_uid871_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_n(0) <= not (shiftedOut_uid871_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_o(10));

    -- r_uid917_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest(MUX,916)@10
    r_uid917_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_s <= shiftedOut_uid871_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_n;
    r_uid917_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_combproc: PROCESS (r_uid917_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_s, rightShiftStage1_uid915_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_mfinal_q, rightShiftStage0Idx7_uid804_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q)
    BEGIN
        CASE (r_uid917_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_s) IS
            WHEN "0" => r_uid917_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_q <= rightShiftStage1_uid915_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_mfinal_q;
            WHEN "1" => r_uid917_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_q <= rightShiftStage0Idx7_uid804_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q;
            WHEN OTHERS => r_uid917_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- alignFracBPostShiftOut_uid615_rImag_uid17_fpComplexMulTest(LOGICAL,614)@10 + 1
    alignFracBPostShiftOut_uid615_rImag_uid17_fpComplexMulTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((48 downto 1 => iShiftedOut_uid614_rImag_uid17_fpComplexMulTest_q(0)) & iShiftedOut_uid614_rImag_uid17_fpComplexMulTest_q));
    alignFracBPostShiftOut_uid615_rImag_uid17_fpComplexMulTest_qi <= r_uid917_alignmentShifter_uid611_rImag_uid17_fpComplexMulTest_q and alignFracBPostShiftOut_uid615_rImag_uid17_fpComplexMulTest_b;
    alignFracBPostShiftOut_uid615_rImag_uid17_fpComplexMulTest_delay : dspba_delay
    GENERIC MAP ( width => 49, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => alignFracBPostShiftOut_uid615_rImag_uid17_fpComplexMulTest_qi, xout => alignFracBPostShiftOut_uid615_rImag_uid17_fpComplexMulTest_q, clk => clk, aclr => areset );

    -- stickyBits_uid616_rImag_uid17_fpComplexMulTest_merged_bit_select(BITSELECT,1066)@11
    stickyBits_uid616_rImag_uid17_fpComplexMulTest_merged_bit_select_b <= alignFracBPostShiftOut_uid615_rImag_uid17_fpComplexMulTest_q(22 downto 0);
    stickyBits_uid616_rImag_uid17_fpComplexMulTest_merged_bit_select_c <= alignFracBPostShiftOut_uid615_rImag_uid17_fpComplexMulTest_q(48 downto 23);

    -- fracBAddOp_uid627_rImag_uid17_fpComplexMulTest(BITJOIN,626)@11
    fracBAddOp_uid627_rImag_uid17_fpComplexMulTest_q <= GND_q & stickyBits_uid616_rImag_uid17_fpComplexMulTest_merged_bit_select_c;

    -- fracBAddOpPostXor_uid628_rImag_uid17_fpComplexMulTest(LOGICAL,627)@11 + 1
    fracBAddOpPostXor_uid628_rImag_uid17_fpComplexMulTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 1 => effSub_uid597_rImag_uid17_fpComplexMulTest_q(0)) & effSub_uid597_rImag_uid17_fpComplexMulTest_q));
    fracBAddOpPostXor_uid628_rImag_uid17_fpComplexMulTest_qi <= fracBAddOp_uid627_rImag_uid17_fpComplexMulTest_q xor fracBAddOpPostXor_uid628_rImag_uid17_fpComplexMulTest_b;
    fracBAddOpPostXor_uid628_rImag_uid17_fpComplexMulTest_delay : dspba_delay
    GENERIC MAP ( width => 27, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => fracBAddOpPostXor_uid628_rImag_uid17_fpComplexMulTest_qi, xout => fracBAddOpPostXor_uid628_rImag_uid17_fpComplexMulTest_q, clk => clk, aclr => areset );

    -- one2b_uid387_rReal_uid16_fpComplexMulTest(CONSTANT,386)
    one2b_uid387_rReal_uid16_fpComplexMulTest_q <= "01";

    -- fracA_uid593_rImag_uid17_fpComplexMulTest(BITSELECT,592)@8
    fracA_uid593_rImag_uid17_fpComplexMulTest_in <= aSig_uid581_rImag_uid17_fpComplexMulTest_q(22 downto 0);
    fracA_uid593_rImag_uid17_fpComplexMulTest_b <= fracA_uid593_rImag_uid17_fpComplexMulTest_in(22 downto 0);

    -- redist40_fracA_uid593_rImag_uid17_fpComplexMulTest_b_4(DELAY,1121)
    redist40_fracA_uid593_rImag_uid17_fpComplexMulTest_b_4 : dspba_delay
    GENERIC MAP ( width => 23, depth => 4, reset_kind => "ASYNC" )
    PORT MAP ( xin => fracA_uid593_rImag_uid17_fpComplexMulTest_b, xout => redist40_fracA_uid593_rImag_uid17_fpComplexMulTest_b_4_q, clk => clk, aclr => areset );

    -- cmpEQ_stickyBits_cZwF_uid618_rImag_uid17_fpComplexMulTest(LOGICAL,617)@11
    cmpEQ_stickyBits_cZwF_uid618_rImag_uid17_fpComplexMulTest_q <= "1" WHEN stickyBits_uid616_rImag_uid17_fpComplexMulTest_merged_bit_select_b = cstZeroWF_uid25_ac_uid6_fpComplexMulTest_q ELSE "0";

    -- effSubInvSticky_uid621_rImag_uid17_fpComplexMulTest(LOGICAL,620)@11 + 1
    effSubInvSticky_uid621_rImag_uid17_fpComplexMulTest_qi <= effSub_uid597_rImag_uid17_fpComplexMulTest_q and cmpEQ_stickyBits_cZwF_uid618_rImag_uid17_fpComplexMulTest_q;
    effSubInvSticky_uid621_rImag_uid17_fpComplexMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => effSubInvSticky_uid621_rImag_uid17_fpComplexMulTest_qi, xout => effSubInvSticky_uid621_rImag_uid17_fpComplexMulTest_q, clk => clk, aclr => areset );

    -- fracAAddOp_uid624_rImag_uid17_fpComplexMulTest(BITJOIN,623)@12
    fracAAddOp_uid624_rImag_uid17_fpComplexMulTest_q <= one2b_uid387_rReal_uid16_fpComplexMulTest_q & redist40_fracA_uid593_rImag_uid17_fpComplexMulTest_b_4_q & GND_q & effSubInvSticky_uid621_rImag_uid17_fpComplexMulTest_q;

    -- fracAddResult_uid629_rImag_uid17_fpComplexMulTest(ADD,628)@12
    fracAddResult_uid629_rImag_uid17_fpComplexMulTest_a <= STD_LOGIC_VECTOR("0" & fracAAddOp_uid624_rImag_uid17_fpComplexMulTest_q);
    fracAddResult_uid629_rImag_uid17_fpComplexMulTest_b <= STD_LOGIC_VECTOR("0" & fracBAddOpPostXor_uid628_rImag_uid17_fpComplexMulTest_q);
    fracAddResult_uid629_rImag_uid17_fpComplexMulTest_o <= STD_LOGIC_VECTOR(UNSIGNED(fracAddResult_uid629_rImag_uid17_fpComplexMulTest_a) + UNSIGNED(fracAddResult_uid629_rImag_uid17_fpComplexMulTest_b));
    fracAddResult_uid629_rImag_uid17_fpComplexMulTest_q <= fracAddResult_uid629_rImag_uid17_fpComplexMulTest_o(27 downto 0);

    -- rangeFracAddResultMwfp3Dto0_uid630_rImag_uid17_fpComplexMulTest(BITSELECT,629)@12
    rangeFracAddResultMwfp3Dto0_uid630_rImag_uid17_fpComplexMulTest_in <= fracAddResult_uid629_rImag_uid17_fpComplexMulTest_q(26 downto 0);
    rangeFracAddResultMwfp3Dto0_uid630_rImag_uid17_fpComplexMulTest_b <= rangeFracAddResultMwfp3Dto0_uid630_rImag_uid17_fpComplexMulTest_in(26 downto 0);

    -- redist33_cmpEQ_stickyBits_cZwF_uid618_rImag_uid17_fpComplexMulTest_q_1(DELAY,1114)
    redist33_cmpEQ_stickyBits_cZwF_uid618_rImag_uid17_fpComplexMulTest_q_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => cmpEQ_stickyBits_cZwF_uid618_rImag_uid17_fpComplexMulTest_q, xout => redist33_cmpEQ_stickyBits_cZwF_uid618_rImag_uid17_fpComplexMulTest_q_1_q, clk => clk, aclr => areset );

    -- invCmpEQ_stickyBits_cZwF_uid619_rImag_uid17_fpComplexMulTest(LOGICAL,618)@12
    invCmpEQ_stickyBits_cZwF_uid619_rImag_uid17_fpComplexMulTest_q <= not (redist33_cmpEQ_stickyBits_cZwF_uid618_rImag_uid17_fpComplexMulTest_q_1_q);

    -- fracGRS_uid631_rImag_uid17_fpComplexMulTest(BITJOIN,630)@12
    fracGRS_uid631_rImag_uid17_fpComplexMulTest_q <= rangeFracAddResultMwfp3Dto0_uid630_rImag_uid17_fpComplexMulTest_b & invCmpEQ_stickyBits_cZwF_uid619_rImag_uid17_fpComplexMulTest_q;

    -- rVStage_uid744_lzCountVal_uid632_rImag_uid17_fpComplexMulTest(BITSELECT,743)@12
    rVStage_uid744_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_b <= fracGRS_uid631_rImag_uid17_fpComplexMulTest_q(27 downto 12);

    -- vCount_uid745_lzCountVal_uid632_rImag_uid17_fpComplexMulTest(LOGICAL,744)@12 + 1
    vCount_uid745_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_qi <= "1" WHEN rVStage_uid744_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_b = zs_uid712_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q ELSE "0";
    vCount_uid745_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => vCount_uid745_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_qi, xout => vCount_uid745_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_q, clk => clk, aclr => areset );

    -- redist16_vCount_uid745_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_q_2(DELAY,1097)
    redist16_vCount_uid745_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_q_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => vCount_uid745_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_q, xout => redist16_vCount_uid745_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_q_2_q, clk => clk, aclr => areset );

    -- redist31_fracGRS_uid631_rImag_uid17_fpComplexMulTest_q_1(DELAY,1112)
    redist31_fracGRS_uid631_rImag_uid17_fpComplexMulTest_q_1 : dspba_delay
    GENERIC MAP ( width => 28, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => fracGRS_uid631_rImag_uid17_fpComplexMulTest_q, xout => redist31_fracGRS_uid631_rImag_uid17_fpComplexMulTest_q_1_q, clk => clk, aclr => areset );

    -- vStage_uid747_lzCountVal_uid632_rImag_uid17_fpComplexMulTest(BITSELECT,746)@13
    vStage_uid747_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_in <= redist31_fracGRS_uid631_rImag_uid17_fpComplexMulTest_q_1_q(11 downto 0);
    vStage_uid747_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_b <= vStage_uid747_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_in(11 downto 0);

    -- mO_uid715_lzCountVal_uid472_rReal_uid16_fpComplexMulTest(CONSTANT,714)
    mO_uid715_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q <= "1111";

    -- cStage_uid748_lzCountVal_uid632_rImag_uid17_fpComplexMulTest(BITJOIN,747)@13
    cStage_uid748_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_q <= vStage_uid747_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_b & mO_uid715_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q;

    -- redist17_rVStage_uid744_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_b_1(DELAY,1098)
    redist17_rVStage_uid744_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_b_1 : dspba_delay
    GENERIC MAP ( width => 16, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => rVStage_uid744_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_b, xout => redist17_rVStage_uid744_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_b_1_q, clk => clk, aclr => areset );

    -- vStagei_uid750_lzCountVal_uid632_rImag_uid17_fpComplexMulTest(MUX,749)@13
    vStagei_uid750_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_s <= vCount_uid745_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_q;
    vStagei_uid750_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_combproc: PROCESS (vStagei_uid750_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_s, redist17_rVStage_uid744_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_b_1_q, cStage_uid748_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_q)
    BEGIN
        CASE (vStagei_uid750_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_s) IS
            WHEN "0" => vStagei_uid750_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_q <= redist17_rVStage_uid744_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_b_1_q;
            WHEN "1" => vStagei_uid750_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_q <= cStage_uid748_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_q;
            WHEN OTHERS => vStagei_uid750_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid752_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_merged_bit_select(BITSELECT,1071)@13
    rVStage_uid752_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_merged_bit_select_b <= vStagei_uid750_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_q(15 downto 8);
    rVStage_uid752_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_merged_bit_select_c <= vStagei_uid750_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_q(7 downto 0);

    -- vCount_uid753_lzCountVal_uid632_rImag_uid17_fpComplexMulTest(LOGICAL,752)@13
    vCount_uid753_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_q <= "1" WHEN rVStage_uid752_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_merged_bit_select_b = cstAllZWE_uid26_ac_uid6_fpComplexMulTest_q ELSE "0";

    -- redist14_vCount_uid753_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_q_1(DELAY,1095)
    redist14_vCount_uid753_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_q_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => vCount_uid753_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_q, xout => redist14_vCount_uid753_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_q_1_q, clk => clk, aclr => areset );

    -- vStagei_uid756_lzCountVal_uid632_rImag_uid17_fpComplexMulTest(MUX,755)@13
    vStagei_uid756_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_s <= vCount_uid753_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_q;
    vStagei_uid756_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_combproc: PROCESS (vStagei_uid756_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_s, rVStage_uid752_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_merged_bit_select_b, rVStage_uid752_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_merged_bit_select_c)
    BEGIN
        CASE (vStagei_uid756_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_s) IS
            WHEN "0" => vStagei_uid756_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_q <= rVStage_uid752_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_merged_bit_select_b;
            WHEN "1" => vStagei_uid756_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_q <= rVStage_uid752_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_merged_bit_select_c;
            WHEN OTHERS => vStagei_uid756_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid758_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_merged_bit_select(BITSELECT,1072)@13
    rVStage_uid758_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_merged_bit_select_b <= vStagei_uid756_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_q(7 downto 4);
    rVStage_uid758_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_merged_bit_select_c <= vStagei_uid756_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_q(3 downto 0);

    -- vCount_uid759_lzCountVal_uid632_rImag_uid17_fpComplexMulTest(LOGICAL,758)@13 + 1
    vCount_uid759_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_qi <= "1" WHEN rVStage_uid758_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_merged_bit_select_b = zs_uid726_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q ELSE "0";
    vCount_uid759_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => vCount_uid759_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_qi, xout => vCount_uid759_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_q, clk => clk, aclr => areset );

    -- redist4_rVStage_uid758_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_merged_bit_select_c_1(DELAY,1085)
    redist4_rVStage_uid758_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_merged_bit_select_c_1 : dspba_delay
    GENERIC MAP ( width => 4, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => rVStage_uid758_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_merged_bit_select_c, xout => redist4_rVStage_uid758_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_merged_bit_select_c_1_q, clk => clk, aclr => areset );

    -- redist3_rVStage_uid758_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_merged_bit_select_b_1(DELAY,1084)
    redist3_rVStage_uid758_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_merged_bit_select_b_1 : dspba_delay
    GENERIC MAP ( width => 4, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => rVStage_uid758_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_merged_bit_select_b, xout => redist3_rVStage_uid758_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_merged_bit_select_b_1_q, clk => clk, aclr => areset );

    -- vStagei_uid762_lzCountVal_uid632_rImag_uid17_fpComplexMulTest(MUX,761)@14
    vStagei_uid762_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_s <= vCount_uid759_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_q;
    vStagei_uid762_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_combproc: PROCESS (vStagei_uid762_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_s, redist3_rVStage_uid758_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_merged_bit_select_b_1_q, redist4_rVStage_uid758_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_merged_bit_select_c_1_q)
    BEGIN
        CASE (vStagei_uid762_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_s) IS
            WHEN "0" => vStagei_uid762_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_q <= redist3_rVStage_uid758_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_merged_bit_select_b_1_q;
            WHEN "1" => vStagei_uid762_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_q <= redist4_rVStage_uid758_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_merged_bit_select_c_1_q;
            WHEN OTHERS => vStagei_uid762_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid764_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_merged_bit_select(BITSELECT,1073)@14
    rVStage_uid764_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_merged_bit_select_b <= vStagei_uid762_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_q(3 downto 2);
    rVStage_uid764_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_merged_bit_select_c <= vStagei_uid762_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_q(1 downto 0);

    -- vCount_uid765_lzCountVal_uid632_rImag_uid17_fpComplexMulTest(LOGICAL,764)@14
    vCount_uid765_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_q <= "1" WHEN rVStage_uid764_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_merged_bit_select_b = zero2b_uid386_rReal_uid16_fpComplexMulTest_q ELSE "0";

    -- vStagei_uid768_lzCountVal_uid632_rImag_uid17_fpComplexMulTest(MUX,767)@14
    vStagei_uid768_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_s <= vCount_uid765_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_q;
    vStagei_uid768_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_combproc: PROCESS (vStagei_uid768_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_s, rVStage_uid764_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_merged_bit_select_b, rVStage_uid764_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_merged_bit_select_c)
    BEGIN
        CASE (vStagei_uid768_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_s) IS
            WHEN "0" => vStagei_uid768_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_q <= rVStage_uid764_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_merged_bit_select_b;
            WHEN "1" => vStagei_uid768_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_q <= rVStage_uid764_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_merged_bit_select_c;
            WHEN OTHERS => vStagei_uid768_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid770_lzCountVal_uid632_rImag_uid17_fpComplexMulTest(BITSELECT,769)@14
    rVStage_uid770_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_b <= vStagei_uid768_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_q(1 downto 1);

    -- vCount_uid771_lzCountVal_uid632_rImag_uid17_fpComplexMulTest(LOGICAL,770)@14
    vCount_uid771_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_q <= "1" WHEN rVStage_uid770_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_b = GND_q ELSE "0";

    -- r_uid772_lzCountVal_uid632_rImag_uid17_fpComplexMulTest(BITJOIN,771)@14
    r_uid772_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_q <= redist16_vCount_uid745_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_q_2_q & redist14_vCount_uid753_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_q_1_q & vCount_uid759_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_q & vCount_uid765_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_q & vCount_uid771_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_q;

    -- aMinusA_uid634_rImag_uid17_fpComplexMulTest(LOGICAL,633)@14 + 1
    aMinusA_uid634_rImag_uid17_fpComplexMulTest_qi <= "1" WHEN r_uid772_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_q = cAmA_uid473_rReal_uid16_fpComplexMulTest_q ELSE "0";
    aMinusA_uid634_rImag_uid17_fpComplexMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => aMinusA_uid634_rImag_uid17_fpComplexMulTest_qi, xout => aMinusA_uid634_rImag_uid17_fpComplexMulTest_q, clk => clk, aclr => areset );

    -- redist30_aMinusA_uid634_rImag_uid17_fpComplexMulTest_q_3(DELAY,1111)
    redist30_aMinusA_uid634_rImag_uid17_fpComplexMulTest_q_3 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => aMinusA_uid634_rImag_uid17_fpComplexMulTest_q, xout => redist30_aMinusA_uid634_rImag_uid17_fpComplexMulTest_q_3_q, clk => clk, aclr => areset );

    -- invAMinusA_uid679_rImag_uid17_fpComplexMulTest(LOGICAL,678)@17
    invAMinusA_uid679_rImag_uid17_fpComplexMulTest_q <= not (redist30_aMinusA_uid634_rImag_uid17_fpComplexMulTest_q_3_q);

    -- redist38_sigA_uid595_rImag_uid17_fpComplexMulTest_b_9(DELAY,1119)
    redist38_sigA_uid595_rImag_uid17_fpComplexMulTest_b_9 : dspba_delay
    GENERIC MAP ( width => 1, depth => 6, reset_kind => "ASYNC" )
    PORT MAP ( xin => redist37_sigA_uid595_rImag_uid17_fpComplexMulTest_b_3_q, xout => redist38_sigA_uid595_rImag_uid17_fpComplexMulTest_b_9_q, clk => clk, aclr => areset );

    -- redist51_excX_uid559_rImag_uid17_fpComplexMulTest_b_10(DELAY,1132)
    redist51_excX_uid559_rImag_uid17_fpComplexMulTest_b_10 : dspba_delay
    GENERIC MAP ( width => 2, depth => 10, reset_kind => "ASYNC" )
    PORT MAP ( xin => excX_uid559_rImag_uid17_fpComplexMulTest_b, xout => redist51_excX_uid559_rImag_uid17_fpComplexMulTest_b_10_q, clk => clk, aclr => areset );

    -- excXReg_uid565_rImag_uid17_fpComplexMulTest(LOGICAL,564)@17
    excXReg_uid565_rImag_uid17_fpComplexMulTest_q <= "1" WHEN redist51_excX_uid559_rImag_uid17_fpComplexMulTest_b_10_q = one2b_uid387_rReal_uid16_fpComplexMulTest_q ELSE "0";

    -- redist52_excX_uid545_rImag_uid17_fpComplexMulTest_b_9(DELAY,1133)
    redist52_excX_uid545_rImag_uid17_fpComplexMulTest_b_9 : dspba_delay
    GENERIC MAP ( width => 2, depth => 9, reset_kind => "ASYNC" )
    PORT MAP ( xin => excX_uid545_rImag_uid17_fpComplexMulTest_b, xout => redist52_excX_uid545_rImag_uid17_fpComplexMulTest_b_9_q, clk => clk, aclr => areset );

    -- excXReg_uid551_rImag_uid17_fpComplexMulTest(LOGICAL,550)@17
    excXReg_uid551_rImag_uid17_fpComplexMulTest_q <= "1" WHEN redist52_excX_uid545_rImag_uid17_fpComplexMulTest_b_9_q = one2b_uid387_rReal_uid16_fpComplexMulTest_q ELSE "0";

    -- redist50_xGTEy_uid573_rImag_uid17_fpComplexMulTest_q_9(DELAY,1131)
    redist50_xGTEy_uid573_rImag_uid17_fpComplexMulTest_q_9 : dspba_delay
    GENERIC MAP ( width => 1, depth => 9, reset_kind => "ASYNC" )
    PORT MAP ( xin => xGTEy_uid573_rImag_uid17_fpComplexMulTest_q, xout => redist50_xGTEy_uid573_rImag_uid17_fpComplexMulTest_q_9_q, clk => clk, aclr => areset );

    -- excBR_uid589_rImag_uid17_fpComplexMulTest(MUX,588)@17
    excBR_uid589_rImag_uid17_fpComplexMulTest_s <= redist50_xGTEy_uid573_rImag_uid17_fpComplexMulTest_q_9_q;
    excBR_uid589_rImag_uid17_fpComplexMulTest_combproc: PROCESS (excBR_uid589_rImag_uid17_fpComplexMulTest_s, excXReg_uid551_rImag_uid17_fpComplexMulTest_q, excXReg_uid565_rImag_uid17_fpComplexMulTest_q)
    BEGIN
        CASE (excBR_uid589_rImag_uid17_fpComplexMulTest_s) IS
            WHEN "0" => excBR_uid589_rImag_uid17_fpComplexMulTest_q <= excXReg_uid551_rImag_uid17_fpComplexMulTest_q;
            WHEN "1" => excBR_uid589_rImag_uid17_fpComplexMulTest_q <= excXReg_uid565_rImag_uid17_fpComplexMulTest_q;
            WHEN OTHERS => excBR_uid589_rImag_uid17_fpComplexMulTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- excAR_uid585_rImag_uid17_fpComplexMulTest(MUX,584)@17
    excAR_uid585_rImag_uid17_fpComplexMulTest_s <= redist50_xGTEy_uid573_rImag_uid17_fpComplexMulTest_q_9_q;
    excAR_uid585_rImag_uid17_fpComplexMulTest_combproc: PROCESS (excAR_uid585_rImag_uid17_fpComplexMulTest_s, excXReg_uid565_rImag_uid17_fpComplexMulTest_q, excXReg_uid551_rImag_uid17_fpComplexMulTest_q)
    BEGIN
        CASE (excAR_uid585_rImag_uid17_fpComplexMulTest_s) IS
            WHEN "0" => excAR_uid585_rImag_uid17_fpComplexMulTest_q <= excXReg_uid565_rImag_uid17_fpComplexMulTest_q;
            WHEN "1" => excAR_uid585_rImag_uid17_fpComplexMulTest_q <= excXReg_uid551_rImag_uid17_fpComplexMulTest_q;
            WHEN OTHERS => excAR_uid585_rImag_uid17_fpComplexMulTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- signRReg_uid680_rImag_uid17_fpComplexMulTest(LOGICAL,679)@17
    signRReg_uid680_rImag_uid17_fpComplexMulTest_q <= excAR_uid585_rImag_uid17_fpComplexMulTest_q and excBR_uid589_rImag_uid17_fpComplexMulTest_q and redist38_sigA_uid595_rImag_uid17_fpComplexMulTest_b_9_q and invAMinusA_uid679_rImag_uid17_fpComplexMulTest_q;

    -- redist36_sigB_uid596_rImag_uid17_fpComplexMulTest_b_9(DELAY,1117)
    redist36_sigB_uid596_rImag_uid17_fpComplexMulTest_b_9 : dspba_delay
    GENERIC MAP ( width => 1, depth => 6, reset_kind => "ASYNC" )
    PORT MAP ( xin => redist35_sigB_uid596_rImag_uid17_fpComplexMulTest_b_3_q, xout => redist36_sigB_uid596_rImag_uid17_fpComplexMulTest_b_9_q, clk => clk, aclr => areset );

    -- redist43_excBZ_uid590_rImag_uid17_fpComplexMulTest_q_9(DELAY,1124)
    redist43_excBZ_uid590_rImag_uid17_fpComplexMulTest_q_9 : dspba_delay
    GENERIC MAP ( width => 1, depth => 8, reset_kind => "ASYNC" )
    PORT MAP ( xin => redist42_excBZ_uid590_rImag_uid17_fpComplexMulTest_q_1_q, xout => redist43_excBZ_uid590_rImag_uid17_fpComplexMulTest_q_9_q, clk => clk, aclr => areset );

    -- excAZ_uid586_rImag_uid17_fpComplexMulTest(MUX,585)@8 + 1
    excAZ_uid586_rImag_uid17_fpComplexMulTest_s <= xGTEy_uid573_rImag_uid17_fpComplexMulTest_q;
    excAZ_uid586_rImag_uid17_fpComplexMulTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            excAZ_uid586_rImag_uid17_fpComplexMulTest_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            CASE (excAZ_uid586_rImag_uid17_fpComplexMulTest_s) IS
                WHEN "0" => excAZ_uid586_rImag_uid17_fpComplexMulTest_q <= excXZero_uid564_rImag_uid17_fpComplexMulTest_q;
                WHEN "1" => excAZ_uid586_rImag_uid17_fpComplexMulTest_q <= excXZero_uid550_rImag_uid17_fpComplexMulTest_q;
                WHEN OTHERS => excAZ_uid586_rImag_uid17_fpComplexMulTest_q <= (others => '0');
            END CASE;
        END IF;
    END PROCESS;

    -- redist45_excAZ_uid586_rImag_uid17_fpComplexMulTest_q_9(DELAY,1126)
    redist45_excAZ_uid586_rImag_uid17_fpComplexMulTest_q_9 : dspba_delay
    GENERIC MAP ( width => 1, depth => 8, reset_kind => "ASYNC" )
    PORT MAP ( xin => excAZ_uid586_rImag_uid17_fpComplexMulTest_q, xout => redist45_excAZ_uid586_rImag_uid17_fpComplexMulTest_q_9_q, clk => clk, aclr => areset );

    -- excAZBZSigASigB_uid684_rImag_uid17_fpComplexMulTest(LOGICAL,683)@17
    excAZBZSigASigB_uid684_rImag_uid17_fpComplexMulTest_q <= redist45_excAZ_uid586_rImag_uid17_fpComplexMulTest_q_9_q and redist43_excBZ_uid590_rImag_uid17_fpComplexMulTest_q_9_q and redist38_sigA_uid595_rImag_uid17_fpComplexMulTest_b_9_q and redist36_sigB_uid596_rImag_uid17_fpComplexMulTest_b_9_q;

    -- excBZARSigA_uid685_rImag_uid17_fpComplexMulTest(LOGICAL,684)@17
    excBZARSigA_uid685_rImag_uid17_fpComplexMulTest_q <= redist43_excBZ_uid590_rImag_uid17_fpComplexMulTest_q_9_q and excAR_uid585_rImag_uid17_fpComplexMulTest_q and redist38_sigA_uid595_rImag_uid17_fpComplexMulTest_b_9_q;

    -- signRZero_uid686_rImag_uid17_fpComplexMulTest(LOGICAL,685)@17
    signRZero_uid686_rImag_uid17_fpComplexMulTest_q <= excBZARSigA_uid685_rImag_uid17_fpComplexMulTest_q or excAZBZSigASigB_uid684_rImag_uid17_fpComplexMulTest_q;

    -- two2b_uid388_rReal_uid16_fpComplexMulTest(CONSTANT,387)
    two2b_uid388_rReal_uid16_fpComplexMulTest_q <= "10";

    -- excXInf_uid566_rImag_uid17_fpComplexMulTest(LOGICAL,565)@17
    excXInf_uid566_rImag_uid17_fpComplexMulTest_q <= "1" WHEN redist51_excX_uid559_rImag_uid17_fpComplexMulTest_b_10_q = two2b_uid388_rReal_uid16_fpComplexMulTest_q ELSE "0";

    -- excXInf_uid552_rImag_uid17_fpComplexMulTest(LOGICAL,551)@17
    excXInf_uid552_rImag_uid17_fpComplexMulTest_q <= "1" WHEN redist52_excX_uid545_rImag_uid17_fpComplexMulTest_b_9_q = two2b_uid388_rReal_uid16_fpComplexMulTest_q ELSE "0";

    -- excBI_uid587_rImag_uid17_fpComplexMulTest(MUX,586)@17
    excBI_uid587_rImag_uid17_fpComplexMulTest_s <= redist50_xGTEy_uid573_rImag_uid17_fpComplexMulTest_q_9_q;
    excBI_uid587_rImag_uid17_fpComplexMulTest_combproc: PROCESS (excBI_uid587_rImag_uid17_fpComplexMulTest_s, excXInf_uid552_rImag_uid17_fpComplexMulTest_q, excXInf_uid566_rImag_uid17_fpComplexMulTest_q)
    BEGIN
        CASE (excBI_uid587_rImag_uid17_fpComplexMulTest_s) IS
            WHEN "0" => excBI_uid587_rImag_uid17_fpComplexMulTest_q <= excXInf_uid552_rImag_uid17_fpComplexMulTest_q;
            WHEN "1" => excBI_uid587_rImag_uid17_fpComplexMulTest_q <= excXInf_uid566_rImag_uid17_fpComplexMulTest_q;
            WHEN OTHERS => excBI_uid587_rImag_uid17_fpComplexMulTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- sigBBInf_uid681_rImag_uid17_fpComplexMulTest(LOGICAL,680)@17
    sigBBInf_uid681_rImag_uid17_fpComplexMulTest_q <= redist36_sigB_uid596_rImag_uid17_fpComplexMulTest_b_9_q and excBI_uid587_rImag_uid17_fpComplexMulTest_q;

    -- excAI_uid583_rImag_uid17_fpComplexMulTest(MUX,582)@17
    excAI_uid583_rImag_uid17_fpComplexMulTest_s <= redist50_xGTEy_uid573_rImag_uid17_fpComplexMulTest_q_9_q;
    excAI_uid583_rImag_uid17_fpComplexMulTest_combproc: PROCESS (excAI_uid583_rImag_uid17_fpComplexMulTest_s, excXInf_uid566_rImag_uid17_fpComplexMulTest_q, excXInf_uid552_rImag_uid17_fpComplexMulTest_q)
    BEGIN
        CASE (excAI_uid583_rImag_uid17_fpComplexMulTest_s) IS
            WHEN "0" => excAI_uid583_rImag_uid17_fpComplexMulTest_q <= excXInf_uid566_rImag_uid17_fpComplexMulTest_q;
            WHEN "1" => excAI_uid583_rImag_uid17_fpComplexMulTest_q <= excXInf_uid552_rImag_uid17_fpComplexMulTest_q;
            WHEN OTHERS => excAI_uid583_rImag_uid17_fpComplexMulTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- sigAAInf_uid682_rImag_uid17_fpComplexMulTest(LOGICAL,681)@17
    sigAAInf_uid682_rImag_uid17_fpComplexMulTest_q <= redist38_sigA_uid595_rImag_uid17_fpComplexMulTest_b_9_q and excAI_uid583_rImag_uid17_fpComplexMulTest_q;

    -- signRInf_uid683_rImag_uid17_fpComplexMulTest(LOGICAL,682)@17
    signRInf_uid683_rImag_uid17_fpComplexMulTest_q <= sigAAInf_uid682_rImag_uid17_fpComplexMulTest_q or sigBBInf_uid681_rImag_uid17_fpComplexMulTest_q;

    -- signRInfRZRReg_uid687_rImag_uid17_fpComplexMulTest(LOGICAL,686)@17 + 1
    signRInfRZRReg_uid687_rImag_uid17_fpComplexMulTest_qi <= signRInf_uid683_rImag_uid17_fpComplexMulTest_q or signRZero_uid686_rImag_uid17_fpComplexMulTest_q or signRReg_uid680_rImag_uid17_fpComplexMulTest_q;
    signRInfRZRReg_uid687_rImag_uid17_fpComplexMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => signRInfRZRReg_uid687_rImag_uid17_fpComplexMulTest_qi, xout => signRInfRZRReg_uid687_rImag_uid17_fpComplexMulTest_q, clk => clk, aclr => areset );

    -- three2b_uid389_rReal_uid16_fpComplexMulTest(CONSTANT,388)
    three2b_uid389_rReal_uid16_fpComplexMulTest_q <= "11";

    -- excXNaN_uid567_rImag_uid17_fpComplexMulTest(LOGICAL,566)@17
    excXNaN_uid567_rImag_uid17_fpComplexMulTest_q <= "1" WHEN redist51_excX_uid559_rImag_uid17_fpComplexMulTest_b_10_q = three2b_uid389_rReal_uid16_fpComplexMulTest_q ELSE "0";

    -- excXNaN_uid553_rImag_uid17_fpComplexMulTest(LOGICAL,552)@17
    excXNaN_uid553_rImag_uid17_fpComplexMulTest_q <= "1" WHEN redist52_excX_uid545_rImag_uid17_fpComplexMulTest_b_9_q = three2b_uid389_rReal_uid16_fpComplexMulTest_q ELSE "0";

    -- excBN_uid588_rImag_uid17_fpComplexMulTest(MUX,587)@17 + 1
    excBN_uid588_rImag_uid17_fpComplexMulTest_s <= redist50_xGTEy_uid573_rImag_uid17_fpComplexMulTest_q_9_q;
    excBN_uid588_rImag_uid17_fpComplexMulTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            excBN_uid588_rImag_uid17_fpComplexMulTest_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            CASE (excBN_uid588_rImag_uid17_fpComplexMulTest_s) IS
                WHEN "0" => excBN_uid588_rImag_uid17_fpComplexMulTest_q <= excXNaN_uid553_rImag_uid17_fpComplexMulTest_q;
                WHEN "1" => excBN_uid588_rImag_uid17_fpComplexMulTest_q <= excXNaN_uid567_rImag_uid17_fpComplexMulTest_q;
                WHEN OTHERS => excBN_uid588_rImag_uid17_fpComplexMulTest_q <= (others => '0');
            END CASE;
        END IF;
    END PROCESS;

    -- excAN_uid584_rImag_uid17_fpComplexMulTest(MUX,583)@17 + 1
    excAN_uid584_rImag_uid17_fpComplexMulTest_s <= redist50_xGTEy_uid573_rImag_uid17_fpComplexMulTest_q_9_q;
    excAN_uid584_rImag_uid17_fpComplexMulTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            excAN_uid584_rImag_uid17_fpComplexMulTest_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            CASE (excAN_uid584_rImag_uid17_fpComplexMulTest_s) IS
                WHEN "0" => excAN_uid584_rImag_uid17_fpComplexMulTest_q <= excXNaN_uid567_rImag_uid17_fpComplexMulTest_q;
                WHEN "1" => excAN_uid584_rImag_uid17_fpComplexMulTest_q <= excXNaN_uid553_rImag_uid17_fpComplexMulTest_q;
                WHEN OTHERS => excAN_uid584_rImag_uid17_fpComplexMulTest_q <= (others => '0');
            END CASE;
        END IF;
    END PROCESS;

    -- excRNaN2_uid674_rImag_uid17_fpComplexMulTest(LOGICAL,673)@18
    excRNaN2_uid674_rImag_uid17_fpComplexMulTest_q <= excAN_uid584_rImag_uid17_fpComplexMulTest_q or excBN_uid588_rImag_uid17_fpComplexMulTest_q;

    -- redist34_effSub_uid597_rImag_uid17_fpComplexMulTest_q_7(DELAY,1115)
    redist34_effSub_uid597_rImag_uid17_fpComplexMulTest_q_7 : dspba_delay
    GENERIC MAP ( width => 1, depth => 7, reset_kind => "ASYNC" )
    PORT MAP ( xin => effSub_uid597_rImag_uid17_fpComplexMulTest_q, xout => redist34_effSub_uid597_rImag_uid17_fpComplexMulTest_q_7_q, clk => clk, aclr => areset );

    -- redist44_excBI_uid587_rImag_uid17_fpComplexMulTest_q_1(DELAY,1125)
    redist44_excBI_uid587_rImag_uid17_fpComplexMulTest_q_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => excBI_uid587_rImag_uid17_fpComplexMulTest_q, xout => redist44_excBI_uid587_rImag_uid17_fpComplexMulTest_q_1_q, clk => clk, aclr => areset );

    -- redist46_excAI_uid583_rImag_uid17_fpComplexMulTest_q_1(DELAY,1127)
    redist46_excAI_uid583_rImag_uid17_fpComplexMulTest_q_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => excAI_uid583_rImag_uid17_fpComplexMulTest_q, xout => redist46_excAI_uid583_rImag_uid17_fpComplexMulTest_q_1_q, clk => clk, aclr => areset );

    -- excAIBISub_uid675_rImag_uid17_fpComplexMulTest(LOGICAL,674)@18
    excAIBISub_uid675_rImag_uid17_fpComplexMulTest_q <= redist46_excAI_uid583_rImag_uid17_fpComplexMulTest_q_1_q and redist44_excBI_uid587_rImag_uid17_fpComplexMulTest_q_1_q and redist34_effSub_uid597_rImag_uid17_fpComplexMulTest_q_7_q;

    -- excRNaN_uid676_rImag_uid17_fpComplexMulTest(LOGICAL,675)@18
    excRNaN_uid676_rImag_uid17_fpComplexMulTest_q <= excAIBISub_uid675_rImag_uid17_fpComplexMulTest_q or excRNaN2_uid674_rImag_uid17_fpComplexMulTest_q;

    -- invExcRNaN_uid688_rImag_uid17_fpComplexMulTest(LOGICAL,687)@18
    invExcRNaN_uid688_rImag_uid17_fpComplexMulTest_q <= not (excRNaN_uid676_rImag_uid17_fpComplexMulTest_q);

    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- signRPostExc_uid689_rImag_uid17_fpComplexMulTest(LOGICAL,688)@18 + 1
    signRPostExc_uid689_rImag_uid17_fpComplexMulTest_qi <= invExcRNaN_uid688_rImag_uid17_fpComplexMulTest_q and signRInfRZRReg_uid687_rImag_uid17_fpComplexMulTest_q;
    signRPostExc_uid689_rImag_uid17_fpComplexMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => signRPostExc_uid689_rImag_uid17_fpComplexMulTest_qi, xout => signRPostExc_uid689_rImag_uid17_fpComplexMulTest_q, clk => clk, aclr => areset );

    -- cRBit_uid486_rReal_uid16_fpComplexMulTest(CONSTANT,485)
    cRBit_uid486_rReal_uid16_fpComplexMulTest_q <= "01000";

    -- leftShiftStage1Idx3Rng3_uid949_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest(BITSELECT,948)@15
    leftShiftStage1Idx3Rng3_uid949_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_in <= leftShiftStage0_uid941_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_mfinal_q(24 downto 0);
    leftShiftStage1Idx3Rng3_uid949_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_b <= leftShiftStage1Idx3Rng3_uid949_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_in(24 downto 0);

    -- leftShiftStage1Idx3_uid950_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest(BITJOIN,949)@15
    leftShiftStage1Idx3_uid950_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_q <= leftShiftStage1Idx3Rng3_uid949_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_b & rightShiftStage1Idx3Pad3_uid814_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q;

    -- leftShiftStage1Idx2Rng2_uid946_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest(BITSELECT,945)@15
    leftShiftStage1Idx2Rng2_uid946_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_in <= leftShiftStage0_uid941_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_mfinal_q(25 downto 0);
    leftShiftStage1Idx2Rng2_uid946_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_b <= leftShiftStage1Idx2Rng2_uid946_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_in(25 downto 0);

    -- leftShiftStage1Idx2_uid947_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest(BITJOIN,946)@15
    leftShiftStage1Idx2_uid947_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_q <= leftShiftStage1Idx2Rng2_uid946_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_b & zero2b_uid386_rReal_uid16_fpComplexMulTest_q;

    -- leftShiftStage1Idx1Rng1_uid943_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest(BITSELECT,942)@15
    leftShiftStage1Idx1Rng1_uid943_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_in <= leftShiftStage0_uid941_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_mfinal_q(26 downto 0);
    leftShiftStage1Idx1Rng1_uid943_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_b <= leftShiftStage1Idx1Rng1_uid943_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_in(26 downto 0);

    -- leftShiftStage1Idx1_uid944_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest(BITJOIN,943)@15
    leftShiftStage1Idx1_uid944_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_q <= leftShiftStage1Idx1Rng1_uid943_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_b & GND_q;

    -- leftShiftStage0Idx7_uid853_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest(CONSTANT,852)
    leftShiftStage0Idx7_uid853_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_q <= "0000000000000000000000000000";

    -- redist32_fracGRS_uid631_rImag_uid17_fpComplexMulTest_q_2(DELAY,1113)
    redist32_fracGRS_uid631_rImag_uid17_fpComplexMulTest_q_2 : dspba_delay
    GENERIC MAP ( width => 28, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => redist31_fracGRS_uid631_rImag_uid17_fpComplexMulTest_q_1_q, xout => redist32_fracGRS_uid631_rImag_uid17_fpComplexMulTest_q_2_q, clk => clk, aclr => areset );

    -- leftShiftStage0Idx6Rng24_uid937_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest(BITSELECT,936)@14
    leftShiftStage0Idx6Rng24_uid937_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_in <= redist32_fracGRS_uid631_rImag_uid17_fpComplexMulTest_q_2_q(3 downto 0);
    leftShiftStage0Idx6Rng24_uid937_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_b <= leftShiftStage0Idx6Rng24_uid937_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_in(3 downto 0);

    -- leftShiftStage0Idx6_uid938_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest(BITJOIN,937)@14
    leftShiftStage0Idx6_uid938_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_q <= leftShiftStage0Idx6Rng24_uid937_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_b & rightShiftStage0Idx3Pad24_uid793_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q;

    -- leftShiftStage0Idx5Rng20_uid934_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest(BITSELECT,933)@14
    leftShiftStage0Idx5Rng20_uid934_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_in <= redist32_fracGRS_uid631_rImag_uid17_fpComplexMulTest_q_2_q(7 downto 0);
    leftShiftStage0Idx5Rng20_uid934_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_b <= leftShiftStage0Idx5Rng20_uid934_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_in(7 downto 0);

    -- leftShiftStage0Idx5Pad20_uid847_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest(CONSTANT,846)
    leftShiftStage0Idx5Pad20_uid847_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_q <= "00000000000000000000";

    -- leftShiftStage0Idx5_uid935_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest(BITJOIN,934)@14
    leftShiftStage0Idx5_uid935_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_q <= leftShiftStage0Idx5Rng20_uid934_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_b & leftShiftStage0Idx5Pad20_uid847_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_q;

    -- redist15_vStage_uid747_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_b_1(DELAY,1096)
    redist15_vStage_uid747_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_b_1 : dspba_delay
    GENERIC MAP ( width => 12, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => vStage_uid747_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_b, xout => redist15_vStage_uid747_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_b_1_q, clk => clk, aclr => areset );

    -- leftShiftStage0Idx4_uid932_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest(BITJOIN,931)@14
    leftShiftStage0Idx4_uid932_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_q <= redist15_vStage_uid747_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_b_1_q & zs_uid712_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q;

    -- leftShiftStageSel4Dto2_uid940_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_merged_bit_select(BITSELECT,1074)@14
    leftShiftStageSel4Dto2_uid940_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_merged_bit_select_b <= r_uid772_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_q(4 downto 2);
    leftShiftStageSel4Dto2_uid940_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_merged_bit_select_c <= r_uid772_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_q(1 downto 0);

    -- leftShiftStage0_uid941_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_selLSBs_merged_bit_select(BITSELECT,1080)@14
    leftShiftStage0_uid941_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_selLSBs_merged_bit_select_b <= leftShiftStageSel4Dto2_uid940_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_merged_bit_select_b(1 downto 0);
    leftShiftStage0_uid941_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_selLSBs_merged_bit_select_c <= leftShiftStageSel4Dto2_uid940_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_merged_bit_select_b(2 downto 2);

    -- leftShiftStage0_uid941_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_msplit_1(MUX,1057)@14 + 1
    leftShiftStage0_uid941_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_msplit_1_s <= leftShiftStage0_uid941_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_selLSBs_merged_bit_select_b;
    leftShiftStage0_uid941_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_msplit_1_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            leftShiftStage0_uid941_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_msplit_1_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            CASE (leftShiftStage0_uid941_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_msplit_1_s) IS
                WHEN "00" => leftShiftStage0_uid941_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_msplit_1_q <= leftShiftStage0Idx4_uid932_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_q;
                WHEN "01" => leftShiftStage0_uid941_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_msplit_1_q <= leftShiftStage0Idx5_uid935_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_q;
                WHEN "10" => leftShiftStage0_uid941_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_msplit_1_q <= leftShiftStage0Idx6_uid938_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_q;
                WHEN "11" => leftShiftStage0_uid941_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_msplit_1_q <= leftShiftStage0Idx7_uid853_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_q;
                WHEN OTHERS => leftShiftStage0_uid941_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_msplit_1_q <= (others => '0');
            END CASE;
        END IF;
    END PROCESS;

    -- leftShiftStage0Idx3Rng12_uid928_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest(BITSELECT,927)@14
    leftShiftStage0Idx3Rng12_uid928_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_in <= redist32_fracGRS_uid631_rImag_uid17_fpComplexMulTest_q_2_q(15 downto 0);
    leftShiftStage0Idx3Rng12_uid928_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_b <= leftShiftStage0Idx3Rng12_uid928_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_in(15 downto 0);

    -- leftShiftStage0Idx3Pad12_uid841_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest(CONSTANT,840)
    leftShiftStage0Idx3Pad12_uid841_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_q <= "000000000000";

    -- leftShiftStage0Idx3_uid929_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest(BITJOIN,928)@14
    leftShiftStage0Idx3_uid929_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_q <= leftShiftStage0Idx3Rng12_uid928_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_b & leftShiftStage0Idx3Pad12_uid841_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_q;

    -- leftShiftStage0Idx2Rng8_uid925_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest(BITSELECT,924)@14
    leftShiftStage0Idx2Rng8_uid925_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_in <= redist32_fracGRS_uid631_rImag_uid17_fpComplexMulTest_q_2_q(19 downto 0);
    leftShiftStage0Idx2Rng8_uid925_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_b <= leftShiftStage0Idx2Rng8_uid925_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_in(19 downto 0);

    -- leftShiftStage0Idx2_uid926_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest(BITJOIN,925)@14
    leftShiftStage0Idx2_uid926_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_q <= leftShiftStage0Idx2Rng8_uid925_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_b & cstAllZWE_uid26_ac_uid6_fpComplexMulTest_q;

    -- leftShiftStage0Idx1Rng4_uid922_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest(BITSELECT,921)@14
    leftShiftStage0Idx1Rng4_uid922_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_in <= redist32_fracGRS_uid631_rImag_uid17_fpComplexMulTest_q_2_q(23 downto 0);
    leftShiftStage0Idx1Rng4_uid922_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_b <= leftShiftStage0Idx1Rng4_uid922_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_in(23 downto 0);

    -- leftShiftStage0Idx1_uid923_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest(BITJOIN,922)@14
    leftShiftStage0Idx1_uid923_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_q <= leftShiftStage0Idx1Rng4_uid922_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_b & zs_uid726_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q;

    -- leftShiftStage0_uid941_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_msplit_0(MUX,1056)@14 + 1
    leftShiftStage0_uid941_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_msplit_0_s <= leftShiftStage0_uid941_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_selLSBs_merged_bit_select_b;
    leftShiftStage0_uid941_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_msplit_0_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            leftShiftStage0_uid941_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_msplit_0_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            CASE (leftShiftStage0_uid941_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_msplit_0_s) IS
                WHEN "00" => leftShiftStage0_uid941_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_msplit_0_q <= redist32_fracGRS_uid631_rImag_uid17_fpComplexMulTest_q_2_q;
                WHEN "01" => leftShiftStage0_uid941_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_msplit_0_q <= leftShiftStage0Idx1_uid923_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_q;
                WHEN "10" => leftShiftStage0_uid941_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_msplit_0_q <= leftShiftStage0Idx2_uid926_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_q;
                WHEN "11" => leftShiftStage0_uid941_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_msplit_0_q <= leftShiftStage0Idx3_uid929_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_q;
                WHEN OTHERS => leftShiftStage0_uid941_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_msplit_0_q <= (others => '0');
            END CASE;
        END IF;
    END PROCESS;

    -- redist0_leftShiftStage0_uid941_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_selLSBs_merged_bit_select_c_1(DELAY,1081)
    redist0_leftShiftStage0_uid941_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_selLSBs_merged_bit_select_c_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => leftShiftStage0_uid941_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_selLSBs_merged_bit_select_c, xout => redist0_leftShiftStage0_uid941_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_selLSBs_merged_bit_select_c_1_q, clk => clk, aclr => areset );

    -- leftShiftStage0_uid941_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_mfinal(MUX,1058)@15
    leftShiftStage0_uid941_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_mfinal_s <= redist0_leftShiftStage0_uid941_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_selLSBs_merged_bit_select_c_1_q;
    leftShiftStage0_uid941_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_mfinal_combproc: PROCESS (leftShiftStage0_uid941_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_mfinal_s, leftShiftStage0_uid941_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_msplit_0_q, leftShiftStage0_uid941_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_msplit_1_q)
    BEGIN
        CASE (leftShiftStage0_uid941_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_mfinal_s) IS
            WHEN "0" => leftShiftStage0_uid941_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_mfinal_q <= leftShiftStage0_uid941_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_msplit_0_q;
            WHEN "1" => leftShiftStage0_uid941_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_mfinal_q <= leftShiftStage0_uid941_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_msplit_1_q;
            WHEN OTHERS => leftShiftStage0_uid941_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_mfinal_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist2_leftShiftStageSel4Dto2_uid940_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_merged_bit_select_c_1(DELAY,1083)
    redist2_leftShiftStageSel4Dto2_uid940_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_merged_bit_select_c_1 : dspba_delay
    GENERIC MAP ( width => 2, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => leftShiftStageSel4Dto2_uid940_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_merged_bit_select_c, xout => redist2_leftShiftStageSel4Dto2_uid940_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_merged_bit_select_c_1_q, clk => clk, aclr => areset );

    -- leftShiftStage1_uid952_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest(MUX,951)@15
    leftShiftStage1_uid952_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_s <= redist2_leftShiftStageSel4Dto2_uid940_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_merged_bit_select_c_1_q;
    leftShiftStage1_uid952_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_combproc: PROCESS (leftShiftStage1_uid952_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_s, leftShiftStage0_uid941_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_mfinal_q, leftShiftStage1Idx1_uid944_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_q, leftShiftStage1Idx2_uid947_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_q, leftShiftStage1Idx3_uid950_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_q)
    BEGIN
        CASE (leftShiftStage1_uid952_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_s) IS
            WHEN "00" => leftShiftStage1_uid952_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_q <= leftShiftStage0_uid941_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_mfinal_q;
            WHEN "01" => leftShiftStage1_uid952_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_q <= leftShiftStage1Idx1_uid944_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_q;
            WHEN "10" => leftShiftStage1_uid952_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_q <= leftShiftStage1Idx2_uid947_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_q;
            WHEN "11" => leftShiftStage1_uid952_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_q <= leftShiftStage1Idx3_uid950_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_q;
            WHEN OTHERS => leftShiftStage1_uid952_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- LSB_uid644_rImag_uid17_fpComplexMulTest(BITSELECT,643)@15
    LSB_uid644_rImag_uid17_fpComplexMulTest_in <= STD_LOGIC_VECTOR(leftShiftStage1_uid952_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_q(4 downto 0));
    LSB_uid644_rImag_uid17_fpComplexMulTest_b <= STD_LOGIC_VECTOR(LSB_uid644_rImag_uid17_fpComplexMulTest_in(4 downto 4));

    -- Guard_uid643_rImag_uid17_fpComplexMulTest(BITSELECT,642)@15
    Guard_uid643_rImag_uid17_fpComplexMulTest_in <= STD_LOGIC_VECTOR(leftShiftStage1_uid952_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_q(3 downto 0));
    Guard_uid643_rImag_uid17_fpComplexMulTest_b <= STD_LOGIC_VECTOR(Guard_uid643_rImag_uid17_fpComplexMulTest_in(3 downto 3));

    -- Round_uid642_rImag_uid17_fpComplexMulTest(BITSELECT,641)@15
    Round_uid642_rImag_uid17_fpComplexMulTest_in <= STD_LOGIC_VECTOR(leftShiftStage1_uid952_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_q(2 downto 0));
    Round_uid642_rImag_uid17_fpComplexMulTest_b <= STD_LOGIC_VECTOR(Round_uid642_rImag_uid17_fpComplexMulTest_in(2 downto 2));

    -- Sticky1_uid641_rImag_uid17_fpComplexMulTest(BITSELECT,640)@15
    Sticky1_uid641_rImag_uid17_fpComplexMulTest_in <= STD_LOGIC_VECTOR(leftShiftStage1_uid952_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_q(1 downto 0));
    Sticky1_uid641_rImag_uid17_fpComplexMulTest_b <= STD_LOGIC_VECTOR(Sticky1_uid641_rImag_uid17_fpComplexMulTest_in(1 downto 1));

    -- Sticky0_uid640_rImag_uid17_fpComplexMulTest(BITSELECT,639)@15
    Sticky0_uid640_rImag_uid17_fpComplexMulTest_in <= STD_LOGIC_VECTOR(leftShiftStage1_uid952_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_q(0 downto 0));
    Sticky0_uid640_rImag_uid17_fpComplexMulTest_b <= STD_LOGIC_VECTOR(Sticky0_uid640_rImag_uid17_fpComplexMulTest_in(0 downto 0));

    -- rndBitCond_uid645_rImag_uid17_fpComplexMulTest(BITJOIN,644)@15
    rndBitCond_uid645_rImag_uid17_fpComplexMulTest_q <= LSB_uid644_rImag_uid17_fpComplexMulTest_b & Guard_uid643_rImag_uid17_fpComplexMulTest_b & Round_uid642_rImag_uid17_fpComplexMulTest_b & Sticky1_uid641_rImag_uid17_fpComplexMulTest_b & Sticky0_uid640_rImag_uid17_fpComplexMulTest_b;

    -- rBi_uid647_rImag_uid17_fpComplexMulTest(LOGICAL,646)@15 + 1
    rBi_uid647_rImag_uid17_fpComplexMulTest_qi <= "1" WHEN rndBitCond_uid645_rImag_uid17_fpComplexMulTest_q = cRBit_uid486_rReal_uid16_fpComplexMulTest_q ELSE "0";
    rBi_uid647_rImag_uid17_fpComplexMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => rBi_uid647_rImag_uid17_fpComplexMulTest_qi, xout => rBi_uid647_rImag_uid17_fpComplexMulTest_q, clk => clk, aclr => areset );

    -- roundBit_uid648_rImag_uid17_fpComplexMulTest(LOGICAL,647)@16
    roundBit_uid648_rImag_uid17_fpComplexMulTest_q <= not (rBi_uid647_rImag_uid17_fpComplexMulTest_q);

    -- oneCST_uid477_rReal_uid16_fpComplexMulTest(CONSTANT,476)
    oneCST_uid477_rReal_uid16_fpComplexMulTest_q <= "00000001";

    -- redist41_expA_uid591_rImag_uid17_fpComplexMulTest_b_6(DELAY,1122)
    redist41_expA_uid591_rImag_uid17_fpComplexMulTest_b_6 : dspba_delay
    GENERIC MAP ( width => 8, depth => 6, reset_kind => "ASYNC" )
    PORT MAP ( xin => expA_uid591_rImag_uid17_fpComplexMulTest_b, xout => redist41_expA_uid591_rImag_uid17_fpComplexMulTest_b_6_q, clk => clk, aclr => areset );

    -- expInc_uid638_rImag_uid17_fpComplexMulTest(ADD,637)@14
    expInc_uid638_rImag_uid17_fpComplexMulTest_a <= STD_LOGIC_VECTOR("0" & redist41_expA_uid591_rImag_uid17_fpComplexMulTest_b_6_q);
    expInc_uid638_rImag_uid17_fpComplexMulTest_b <= STD_LOGIC_VECTOR("0" & oneCST_uid477_rReal_uid16_fpComplexMulTest_q);
    expInc_uid638_rImag_uid17_fpComplexMulTest_o <= STD_LOGIC_VECTOR(UNSIGNED(expInc_uid638_rImag_uid17_fpComplexMulTest_a) + UNSIGNED(expInc_uid638_rImag_uid17_fpComplexMulTest_b));
    expInc_uid638_rImag_uid17_fpComplexMulTest_q <= expInc_uid638_rImag_uid17_fpComplexMulTest_o(8 downto 0);

    -- expPostNorm_uid639_rImag_uid17_fpComplexMulTest(SUB,638)@14 + 1
    expPostNorm_uid639_rImag_uid17_fpComplexMulTest_a <= STD_LOGIC_VECTOR("0" & expInc_uid638_rImag_uid17_fpComplexMulTest_q);
    expPostNorm_uid639_rImag_uid17_fpComplexMulTest_b <= STD_LOGIC_VECTOR("00000" & r_uid772_lzCountVal_uid632_rImag_uid17_fpComplexMulTest_q);
    expPostNorm_uid639_rImag_uid17_fpComplexMulTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            expPostNorm_uid639_rImag_uid17_fpComplexMulTest_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            expPostNorm_uid639_rImag_uid17_fpComplexMulTest_o <= STD_LOGIC_VECTOR(UNSIGNED(expPostNorm_uid639_rImag_uid17_fpComplexMulTest_a) - UNSIGNED(expPostNorm_uid639_rImag_uid17_fpComplexMulTest_b));
        END IF;
    END PROCESS;
    expPostNorm_uid639_rImag_uid17_fpComplexMulTest_q <= expPostNorm_uid639_rImag_uid17_fpComplexMulTest_o(9 downto 0);

    -- redist29_expPostNorm_uid639_rImag_uid17_fpComplexMulTest_q_2(DELAY,1110)
    redist29_expPostNorm_uid639_rImag_uid17_fpComplexMulTest_q_2 : dspba_delay
    GENERIC MAP ( width => 10, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => expPostNorm_uid639_rImag_uid17_fpComplexMulTest_q, xout => redist29_expPostNorm_uid639_rImag_uid17_fpComplexMulTest_q_2_q, clk => clk, aclr => areset );

    -- fracPostNorm_uid636_rImag_uid17_fpComplexMulTest(BITSELECT,635)@15
    fracPostNorm_uid636_rImag_uid17_fpComplexMulTest_b <= leftShiftStage1_uid952_fracPostNormExt_uid635_rImag_uid17_fpComplexMulTest_q(27 downto 1);

    -- fracPostNormRndRange_uid649_rImag_uid17_fpComplexMulTest(BITSELECT,648)@15
    fracPostNormRndRange_uid649_rImag_uid17_fpComplexMulTest_in <= fracPostNorm_uid636_rImag_uid17_fpComplexMulTest_b(25 downto 0);
    fracPostNormRndRange_uid649_rImag_uid17_fpComplexMulTest_b <= fracPostNormRndRange_uid649_rImag_uid17_fpComplexMulTest_in(25 downto 2);

    -- redist28_fracPostNormRndRange_uid649_rImag_uid17_fpComplexMulTest_b_1(DELAY,1109)
    redist28_fracPostNormRndRange_uid649_rImag_uid17_fpComplexMulTest_b_1 : dspba_delay
    GENERIC MAP ( width => 24, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => fracPostNormRndRange_uid649_rImag_uid17_fpComplexMulTest_b, xout => redist28_fracPostNormRndRange_uid649_rImag_uid17_fpComplexMulTest_b_1_q, clk => clk, aclr => areset );

    -- expFracR_uid650_rImag_uid17_fpComplexMulTest(BITJOIN,649)@16
    expFracR_uid650_rImag_uid17_fpComplexMulTest_q <= redist29_expPostNorm_uid639_rImag_uid17_fpComplexMulTest_q_2_q & redist28_fracPostNormRndRange_uid649_rImag_uid17_fpComplexMulTest_b_1_q;

    -- rndExpFrac_uid651_rImag_uid17_fpComplexMulTest(ADD,650)@16 + 1
    rndExpFrac_uid651_rImag_uid17_fpComplexMulTest_a <= STD_LOGIC_VECTOR("0" & expFracR_uid650_rImag_uid17_fpComplexMulTest_q);
    rndExpFrac_uid651_rImag_uid17_fpComplexMulTest_b <= STD_LOGIC_VECTOR("0000000000000000000000000000000000" & roundBit_uid648_rImag_uid17_fpComplexMulTest_q);
    rndExpFrac_uid651_rImag_uid17_fpComplexMulTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            rndExpFrac_uid651_rImag_uid17_fpComplexMulTest_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            rndExpFrac_uid651_rImag_uid17_fpComplexMulTest_o <= STD_LOGIC_VECTOR(UNSIGNED(rndExpFrac_uid651_rImag_uid17_fpComplexMulTest_a) + UNSIGNED(rndExpFrac_uid651_rImag_uid17_fpComplexMulTest_b));
        END IF;
    END PROCESS;
    rndExpFrac_uid651_rImag_uid17_fpComplexMulTest_q <= rndExpFrac_uid651_rImag_uid17_fpComplexMulTest_o(34 downto 0);

    -- expRPreExc_uid664_rImag_uid17_fpComplexMulTest(BITSELECT,663)@17
    expRPreExc_uid664_rImag_uid17_fpComplexMulTest_in <= rndExpFrac_uid651_rImag_uid17_fpComplexMulTest_q(31 downto 0);
    expRPreExc_uid664_rImag_uid17_fpComplexMulTest_b <= expRPreExc_uid664_rImag_uid17_fpComplexMulTest_in(31 downto 24);

    -- redist26_expRPreExc_uid664_rImag_uid17_fpComplexMulTest_b_2(DELAY,1107)
    redist26_expRPreExc_uid664_rImag_uid17_fpComplexMulTest_b_2 : dspba_delay
    GENERIC MAP ( width => 8, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => expRPreExc_uid664_rImag_uid17_fpComplexMulTest_b, xout => redist26_expRPreExc_uid664_rImag_uid17_fpComplexMulTest_b_2_q, clk => clk, aclr => areset );

    -- rndExpFracOvfBits_uid656_rImag_uid17_fpComplexMulTest(BITSELECT,655)@17
    rndExpFracOvfBits_uid656_rImag_uid17_fpComplexMulTest_in <= rndExpFrac_uid651_rImag_uid17_fpComplexMulTest_q(33 downto 0);
    rndExpFracOvfBits_uid656_rImag_uid17_fpComplexMulTest_b <= rndExpFracOvfBits_uid656_rImag_uid17_fpComplexMulTest_in(33 downto 32);

    -- rOvfExtraBits_uid657_rImag_uid17_fpComplexMulTest(LOGICAL,656)@17
    rOvfExtraBits_uid657_rImag_uid17_fpComplexMulTest_q <= "1" WHEN rndExpFracOvfBits_uid656_rImag_uid17_fpComplexMulTest_b = one2b_uid387_rReal_uid16_fpComplexMulTest_q ELSE "0";

    -- wEP2AllOwE_uid492_rReal_uid16_fpComplexMulTest(CONSTANT,491)
    wEP2AllOwE_uid492_rReal_uid16_fpComplexMulTest_q <= "0011111111";

    -- rndExp_uid653_rImag_uid17_fpComplexMulTest(BITSELECT,652)@17
    rndExp_uid653_rImag_uid17_fpComplexMulTest_in <= rndExpFrac_uid651_rImag_uid17_fpComplexMulTest_q(33 downto 0);
    rndExp_uid653_rImag_uid17_fpComplexMulTest_b <= rndExp_uid653_rImag_uid17_fpComplexMulTest_in(33 downto 24);

    -- rOvfEQMax_uid654_rImag_uid17_fpComplexMulTest(LOGICAL,653)@17
    rOvfEQMax_uid654_rImag_uid17_fpComplexMulTest_q <= "1" WHEN rndExp_uid653_rImag_uid17_fpComplexMulTest_b = wEP2AllOwE_uid492_rReal_uid16_fpComplexMulTest_q ELSE "0";

    -- rOvf_uid658_rImag_uid17_fpComplexMulTest(LOGICAL,657)@17
    rOvf_uid658_rImag_uid17_fpComplexMulTest_q <= rOvfEQMax_uid654_rImag_uid17_fpComplexMulTest_q or rOvfExtraBits_uid657_rImag_uid17_fpComplexMulTest_q;

    -- regInputs_uid665_rImag_uid17_fpComplexMulTest(LOGICAL,664)@17
    regInputs_uid665_rImag_uid17_fpComplexMulTest_q <= excAR_uid585_rImag_uid17_fpComplexMulTest_q and excBR_uid589_rImag_uid17_fpComplexMulTest_q;

    -- aZeroBRegFPLib_uid669_rImag_uid17_fpComplexMulTest(LOGICAL,668)@17
    aZeroBRegFPLib_uid669_rImag_uid17_fpComplexMulTest_q <= redist45_excAZ_uid586_rImag_uid17_fpComplexMulTest_q_9_q and excBR_uid589_rImag_uid17_fpComplexMulTest_q;

    -- aRegBZeroFPLib_uid668_rImag_uid17_fpComplexMulTest(LOGICAL,667)@17
    aRegBZeroFPLib_uid668_rImag_uid17_fpComplexMulTest_q <= excAR_uid585_rImag_uid17_fpComplexMulTest_q and redist43_excBZ_uid590_rImag_uid17_fpComplexMulTest_q_9_q;

    -- fpLibRegInputs_uid670_rImag_uid17_fpComplexMulTest(LOGICAL,669)@17
    fpLibRegInputs_uid670_rImag_uid17_fpComplexMulTest_q <= aRegBZeroFPLib_uid668_rImag_uid17_fpComplexMulTest_q or aZeroBRegFPLib_uid669_rImag_uid17_fpComplexMulTest_q or regInputs_uid665_rImag_uid17_fpComplexMulTest_q;

    -- rInfOvf_uid671_rImag_uid17_fpComplexMulTest(LOGICAL,670)@17 + 1
    rInfOvf_uid671_rImag_uid17_fpComplexMulTest_qi <= fpLibRegInputs_uid670_rImag_uid17_fpComplexMulTest_q and rOvf_uid658_rImag_uid17_fpComplexMulTest_q;
    rInfOvf_uid671_rImag_uid17_fpComplexMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => rInfOvf_uid671_rImag_uid17_fpComplexMulTest_qi, xout => rInfOvf_uid671_rImag_uid17_fpComplexMulTest_q, clk => clk, aclr => areset );

    -- excRInfVInC_uid672_rImag_uid17_fpComplexMulTest(BITJOIN,671)@18
    excRInfVInC_uid672_rImag_uid17_fpComplexMulTest_q <= rInfOvf_uid671_rImag_uid17_fpComplexMulTest_q & excBN_uid588_rImag_uid17_fpComplexMulTest_q & excAN_uid584_rImag_uid17_fpComplexMulTest_q & redist44_excBI_uid587_rImag_uid17_fpComplexMulTest_q_1_q & redist46_excAI_uid583_rImag_uid17_fpComplexMulTest_q_1_q & redist34_effSub_uid597_rImag_uid17_fpComplexMulTest_q_7_q;

    -- excRInf_uid673_rImag_uid17_fpComplexMulTest(LOOKUP,672)@18
    excRInf_uid673_rImag_uid17_fpComplexMulTest_combproc: PROCESS (excRInfVInC_uid672_rImag_uid17_fpComplexMulTest_q)
    BEGIN
        -- Begin reserved scope level
        CASE (excRInfVInC_uid672_rImag_uid17_fpComplexMulTest_q) IS
            WHEN "000000" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "0";
            WHEN "000001" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "0";
            WHEN "000010" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "1";
            WHEN "000011" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "1";
            WHEN "000100" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "1";
            WHEN "000101" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "1";
            WHEN "000110" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "1";
            WHEN "000111" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "0";
            WHEN "001000" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "0";
            WHEN "001001" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "0";
            WHEN "001010" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "0";
            WHEN "001011" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "0";
            WHEN "001100" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "0";
            WHEN "001101" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "0";
            WHEN "001110" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "0";
            WHEN "001111" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "0";
            WHEN "010000" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "0";
            WHEN "010001" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "0";
            WHEN "010010" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "0";
            WHEN "010011" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "0";
            WHEN "010100" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "0";
            WHEN "010101" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "0";
            WHEN "010110" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "0";
            WHEN "010111" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "0";
            WHEN "011000" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "0";
            WHEN "011001" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "0";
            WHEN "011010" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "0";
            WHEN "011011" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "0";
            WHEN "011100" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "0";
            WHEN "011101" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "0";
            WHEN "011110" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "0";
            WHEN "011111" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "0";
            WHEN "100000" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "1";
            WHEN "100001" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "1";
            WHEN "100010" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "0";
            WHEN "100011" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "0";
            WHEN "100100" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "0";
            WHEN "100101" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "0";
            WHEN "100110" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "0";
            WHEN "100111" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "0";
            WHEN "101000" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "0";
            WHEN "101001" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "0";
            WHEN "101010" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "0";
            WHEN "101011" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "0";
            WHEN "101100" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "0";
            WHEN "101101" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "0";
            WHEN "101110" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "0";
            WHEN "101111" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "0";
            WHEN "110000" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "0";
            WHEN "110001" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "0";
            WHEN "110010" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "0";
            WHEN "110011" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "0";
            WHEN "110100" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "0";
            WHEN "110101" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "0";
            WHEN "110110" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "0";
            WHEN "110111" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "0";
            WHEN "111000" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "0";
            WHEN "111001" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "0";
            WHEN "111010" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "0";
            WHEN "111011" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "0";
            WHEN "111100" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "0";
            WHEN "111101" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "0";
            WHEN "111110" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "0";
            WHEN "111111" => excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= "0";
            WHEN OTHERS => -- unreachable
                           excRInf_uid673_rImag_uid17_fpComplexMulTest_q <= (others => '-');
        END CASE;
        -- End reserved scope level
    END PROCESS;

    -- rUdfExtraBit_uid661_rImag_uid17_fpComplexMulTest(BITSELECT,660)@17
    rUdfExtraBit_uid661_rImag_uid17_fpComplexMulTest_in <= STD_LOGIC_VECTOR(rndExpFrac_uid651_rImag_uid17_fpComplexMulTest_q(33 downto 0));
    rUdfExtraBit_uid661_rImag_uid17_fpComplexMulTest_b <= STD_LOGIC_VECTOR(rUdfExtraBit_uid661_rImag_uid17_fpComplexMulTest_in(33 downto 33));

    -- wEP2AllZ_uid499_rReal_uid16_fpComplexMulTest(CONSTANT,498)
    wEP2AllZ_uid499_rReal_uid16_fpComplexMulTest_q <= "0000000000";

    -- rUdfEQMin_uid660_rImag_uid17_fpComplexMulTest(LOGICAL,659)@17
    rUdfEQMin_uid660_rImag_uid17_fpComplexMulTest_q <= "1" WHEN rndExp_uid653_rImag_uid17_fpComplexMulTest_b = wEP2AllZ_uid499_rReal_uid16_fpComplexMulTest_q ELSE "0";

    -- rUdf_uid662_rImag_uid17_fpComplexMulTest(LOGICAL,661)@17
    rUdf_uid662_rImag_uid17_fpComplexMulTest_q <= rUdfEQMin_uid660_rImag_uid17_fpComplexMulTest_q or rUdfExtraBit_uid661_rImag_uid17_fpComplexMulTest_b;

    -- excRZeroVInC_uid666_rImag_uid17_fpComplexMulTest(BITJOIN,665)@17
    excRZeroVInC_uid666_rImag_uid17_fpComplexMulTest_q <= redist30_aMinusA_uid634_rImag_uid17_fpComplexMulTest_q_3_q & rUdf_uid662_rImag_uid17_fpComplexMulTest_q & regInputs_uid665_rImag_uid17_fpComplexMulTest_q & redist43_excBZ_uid590_rImag_uid17_fpComplexMulTest_q_9_q & redist45_excAZ_uid586_rImag_uid17_fpComplexMulTest_q_9_q;

    -- excRZero_uid667_rImag_uid17_fpComplexMulTest(LOOKUP,666)@17 + 1
    excRZero_uid667_rImag_uid17_fpComplexMulTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            excRZero_uid667_rImag_uid17_fpComplexMulTest_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            CASE (excRZeroVInC_uid666_rImag_uid17_fpComplexMulTest_q) IS
                WHEN "00000" => excRZero_uid667_rImag_uid17_fpComplexMulTest_q <= "0";
                WHEN "00001" => excRZero_uid667_rImag_uid17_fpComplexMulTest_q <= "0";
                WHEN "00010" => excRZero_uid667_rImag_uid17_fpComplexMulTest_q <= "0";
                WHEN "00011" => excRZero_uid667_rImag_uid17_fpComplexMulTest_q <= "1";
                WHEN "00100" => excRZero_uid667_rImag_uid17_fpComplexMulTest_q <= "0";
                WHEN "00101" => excRZero_uid667_rImag_uid17_fpComplexMulTest_q <= "0";
                WHEN "00110" => excRZero_uid667_rImag_uid17_fpComplexMulTest_q <= "0";
                WHEN "00111" => excRZero_uid667_rImag_uid17_fpComplexMulTest_q <= "0";
                WHEN "01000" => excRZero_uid667_rImag_uid17_fpComplexMulTest_q <= "0";
                WHEN "01001" => excRZero_uid667_rImag_uid17_fpComplexMulTest_q <= "0";
                WHEN "01010" => excRZero_uid667_rImag_uid17_fpComplexMulTest_q <= "0";
                WHEN "01011" => excRZero_uid667_rImag_uid17_fpComplexMulTest_q <= "1";
                WHEN "01100" => excRZero_uid667_rImag_uid17_fpComplexMulTest_q <= "1";
                WHEN "01101" => excRZero_uid667_rImag_uid17_fpComplexMulTest_q <= "0";
                WHEN "01110" => excRZero_uid667_rImag_uid17_fpComplexMulTest_q <= "0";
                WHEN "01111" => excRZero_uid667_rImag_uid17_fpComplexMulTest_q <= "0";
                WHEN "10000" => excRZero_uid667_rImag_uid17_fpComplexMulTest_q <= "0";
                WHEN "10001" => excRZero_uid667_rImag_uid17_fpComplexMulTest_q <= "0";
                WHEN "10010" => excRZero_uid667_rImag_uid17_fpComplexMulTest_q <= "0";
                WHEN "10011" => excRZero_uid667_rImag_uid17_fpComplexMulTest_q <= "1";
                WHEN "10100" => excRZero_uid667_rImag_uid17_fpComplexMulTest_q <= "1";
                WHEN "10101" => excRZero_uid667_rImag_uid17_fpComplexMulTest_q <= "0";
                WHEN "10110" => excRZero_uid667_rImag_uid17_fpComplexMulTest_q <= "0";
                WHEN "10111" => excRZero_uid667_rImag_uid17_fpComplexMulTest_q <= "0";
                WHEN "11000" => excRZero_uid667_rImag_uid17_fpComplexMulTest_q <= "0";
                WHEN "11001" => excRZero_uid667_rImag_uid17_fpComplexMulTest_q <= "0";
                WHEN "11010" => excRZero_uid667_rImag_uid17_fpComplexMulTest_q <= "0";
                WHEN "11011" => excRZero_uid667_rImag_uid17_fpComplexMulTest_q <= "1";
                WHEN "11100" => excRZero_uid667_rImag_uid17_fpComplexMulTest_q <= "1";
                WHEN "11101" => excRZero_uid667_rImag_uid17_fpComplexMulTest_q <= "0";
                WHEN "11110" => excRZero_uid667_rImag_uid17_fpComplexMulTest_q <= "0";
                WHEN "11111" => excRZero_uid667_rImag_uid17_fpComplexMulTest_q <= "0";
                WHEN OTHERS => -- unreachable
                               excRZero_uid667_rImag_uid17_fpComplexMulTest_q <= (others => '-');
            END CASE;
        END IF;
    END PROCESS;

    -- concExc_uid677_rImag_uid17_fpComplexMulTest(BITJOIN,676)@18
    concExc_uid677_rImag_uid17_fpComplexMulTest_q <= excRNaN_uid676_rImag_uid17_fpComplexMulTest_q & excRInf_uid673_rImag_uid17_fpComplexMulTest_q & excRZero_uid667_rImag_uid17_fpComplexMulTest_q;

    -- excREnc_uid678_rImag_uid17_fpComplexMulTest(LOOKUP,677)@18 + 1
    excREnc_uid678_rImag_uid17_fpComplexMulTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            excREnc_uid678_rImag_uid17_fpComplexMulTest_q <= "01";
        ELSIF (clk'EVENT AND clk = '1') THEN
            CASE (concExc_uid677_rImag_uid17_fpComplexMulTest_q) IS
                WHEN "000" => excREnc_uid678_rImag_uid17_fpComplexMulTest_q <= "01";
                WHEN "001" => excREnc_uid678_rImag_uid17_fpComplexMulTest_q <= "00";
                WHEN "010" => excREnc_uid678_rImag_uid17_fpComplexMulTest_q <= "10";
                WHEN "011" => excREnc_uid678_rImag_uid17_fpComplexMulTest_q <= "10";
                WHEN "100" => excREnc_uid678_rImag_uid17_fpComplexMulTest_q <= "11";
                WHEN "101" => excREnc_uid678_rImag_uid17_fpComplexMulTest_q <= "11";
                WHEN "110" => excREnc_uid678_rImag_uid17_fpComplexMulTest_q <= "11";
                WHEN "111" => excREnc_uid678_rImag_uid17_fpComplexMulTest_q <= "11";
                WHEN OTHERS => -- unreachable
                               excREnc_uid678_rImag_uid17_fpComplexMulTest_q <= (others => '-');
            END CASE;
        END IF;
    END PROCESS;

    -- expRPostExc_uid697_rImag_uid17_fpComplexMulTest(MUX,696)@19
    expRPostExc_uid697_rImag_uid17_fpComplexMulTest_s <= excREnc_uid678_rImag_uid17_fpComplexMulTest_q;
    expRPostExc_uid697_rImag_uid17_fpComplexMulTest_combproc: PROCESS (expRPostExc_uid697_rImag_uid17_fpComplexMulTest_s, cstAllZWE_uid26_ac_uid6_fpComplexMulTest_q, redist26_expRPreExc_uid664_rImag_uid17_fpComplexMulTest_b_2_q, cstAllOWE_uid24_ac_uid6_fpComplexMulTest_q)
    BEGIN
        CASE (expRPostExc_uid697_rImag_uid17_fpComplexMulTest_s) IS
            WHEN "00" => expRPostExc_uid697_rImag_uid17_fpComplexMulTest_q <= cstAllZWE_uid26_ac_uid6_fpComplexMulTest_q;
            WHEN "01" => expRPostExc_uid697_rImag_uid17_fpComplexMulTest_q <= redist26_expRPreExc_uid664_rImag_uid17_fpComplexMulTest_b_2_q;
            WHEN "10" => expRPostExc_uid697_rImag_uid17_fpComplexMulTest_q <= cstAllOWE_uid24_ac_uid6_fpComplexMulTest_q;
            WHEN "11" => expRPostExc_uid697_rImag_uid17_fpComplexMulTest_q <= cstAllOWE_uid24_ac_uid6_fpComplexMulTest_q;
            WHEN OTHERS => expRPostExc_uid697_rImag_uid17_fpComplexMulTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- oneFracRPostExc2_uid530_rReal_uid16_fpComplexMulTest(CONSTANT,529)
    oneFracRPostExc2_uid530_rReal_uid16_fpComplexMulTest_q <= "00000000000000000000001";

    -- fracRPreExc_uid663_rImag_uid17_fpComplexMulTest(BITSELECT,662)@17
    fracRPreExc_uid663_rImag_uid17_fpComplexMulTest_in <= rndExpFrac_uid651_rImag_uid17_fpComplexMulTest_q(23 downto 0);
    fracRPreExc_uid663_rImag_uid17_fpComplexMulTest_b <= fracRPreExc_uid663_rImag_uid17_fpComplexMulTest_in(23 downto 1);

    -- redist27_fracRPreExc_uid663_rImag_uid17_fpComplexMulTest_b_2(DELAY,1108)
    redist27_fracRPreExc_uid663_rImag_uid17_fpComplexMulTest_b_2 : dspba_delay
    GENERIC MAP ( width => 23, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => fracRPreExc_uid663_rImag_uid17_fpComplexMulTest_b, xout => redist27_fracRPreExc_uid663_rImag_uid17_fpComplexMulTest_b_2_q, clk => clk, aclr => areset );

    -- fracRPostExc_uid693_rImag_uid17_fpComplexMulTest(MUX,692)@19
    fracRPostExc_uid693_rImag_uid17_fpComplexMulTest_s <= excREnc_uid678_rImag_uid17_fpComplexMulTest_q;
    fracRPostExc_uid693_rImag_uid17_fpComplexMulTest_combproc: PROCESS (fracRPostExc_uid693_rImag_uid17_fpComplexMulTest_s, cstZeroWF_uid25_ac_uid6_fpComplexMulTest_q, redist27_fracRPreExc_uid663_rImag_uid17_fpComplexMulTest_b_2_q, oneFracRPostExc2_uid530_rReal_uid16_fpComplexMulTest_q)
    BEGIN
        CASE (fracRPostExc_uid693_rImag_uid17_fpComplexMulTest_s) IS
            WHEN "00" => fracRPostExc_uid693_rImag_uid17_fpComplexMulTest_q <= cstZeroWF_uid25_ac_uid6_fpComplexMulTest_q;
            WHEN "01" => fracRPostExc_uid693_rImag_uid17_fpComplexMulTest_q <= redist27_fracRPreExc_uid663_rImag_uid17_fpComplexMulTest_b_2_q;
            WHEN "10" => fracRPostExc_uid693_rImag_uid17_fpComplexMulTest_q <= cstZeroWF_uid25_ac_uid6_fpComplexMulTest_q;
            WHEN "11" => fracRPostExc_uid693_rImag_uid17_fpComplexMulTest_q <= oneFracRPostExc2_uid530_rReal_uid16_fpComplexMulTest_q;
            WHEN OTHERS => fracRPostExc_uid693_rImag_uid17_fpComplexMulTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- R_uid698_rImag_uid17_fpComplexMulTest(BITJOIN,697)@19
    R_uid698_rImag_uid17_fpComplexMulTest_q <= signRPostExc_uid689_rImag_uid17_fpComplexMulTest_q & expRPostExc_uid697_rImag_uid17_fpComplexMulTest_q & fracRPostExc_uid693_rImag_uid17_fpComplexMulTest_q;

    -- excYZAndExcXI_uid190_bd_uid7_fpComplexMulTest(LOGICAL,189)@6
    excYZAndExcXI_uid190_bd_uid7_fpComplexMulTest_q <= redist97_excZ_y_uid133_bd_uid7_fpComplexMulTest_q_2_q and excI_x_uid123_bd_uid7_fpComplexMulTest_q;

    -- excXZAndExcYI_uid191_bd_uid7_fpComplexMulTest(LOGICAL,190)@6
    excXZAndExcYI_uid191_bd_uid7_fpComplexMulTest_q <= redist100_excZ_x_uid119_bd_uid7_fpComplexMulTest_q_2_q and excI_y_uid137_bd_uid7_fpComplexMulTest_q;

    -- ZeroTimesInf_uid192_bd_uid7_fpComplexMulTest(LOGICAL,191)@6
    ZeroTimesInf_uid192_bd_uid7_fpComplexMulTest_q <= excXZAndExcYI_uid191_bd_uid7_fpComplexMulTest_q or excYZAndExcXI_uid190_bd_uid7_fpComplexMulTest_q;

    -- excRNaN_uid193_bd_uid7_fpComplexMulTest(LOGICAL,192)@6 + 1
    excRNaN_uid193_bd_uid7_fpComplexMulTest_qi <= excN_x_uid124_bd_uid7_fpComplexMulTest_q or excN_y_uid138_bd_uid7_fpComplexMulTest_q or ZeroTimesInf_uid192_bd_uid7_fpComplexMulTest_q;
    excRNaN_uid193_bd_uid7_fpComplexMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => excRNaN_uid193_bd_uid7_fpComplexMulTest_qi, xout => excRNaN_uid193_bd_uid7_fpComplexMulTest_q, clk => clk, aclr => areset );

    -- prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im6(MULT,978)@1 + 2
    prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im6_a0 <= redist10_prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_bs2_merged_bit_select_b_1_q;
    prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im6_b0 <= redist11_prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_bs1_merged_bit_select_c_1_q;
    prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im6_reset <= areset;
    prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im6_component : lpm_mult
    GENERIC MAP (
        lpm_widtha => 18,
        lpm_widthb => 6,
        lpm_widthp => 24,
        lpm_widths => 1,
        lpm_type => "LPM_MULT",
        lpm_representation => "UNSIGNED",
        lpm_hint => "DEDICATED_MULTIPLIER_CIRCUITRY=YES, MAXIMIZE_SPEED=5",
        lpm_pipeline => 2
    )
    PORT MAP (
        dataa => prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im6_a0,
        datab => prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im6_b0,
        clken => VCC_q(0),
        aclr => prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im6_reset,
        clock => clk,
        result => prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im6_s1
    );
    prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im6_q <= prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im6_s1;

    -- prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_align_15(BITSHIFT,987)@3
    prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_align_15_qint <= prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im6_q & "000000000000000000";
    prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_align_15_q <= prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_align_15_qint(41 downto 0);

    -- prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im3(MULT,975)@0 + 2
    prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im3_a0 <= prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_bs1_merged_bit_select_b;
    prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im3_b0 <= prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_bs2_merged_bit_select_c;
    prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im3_reset <= areset;
    prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im3_component : lpm_mult
    GENERIC MAP (
        lpm_widtha => 18,
        lpm_widthb => 6,
        lpm_widthp => 24,
        lpm_widths => 1,
        lpm_type => "LPM_MULT",
        lpm_representation => "UNSIGNED",
        lpm_hint => "DEDICATED_MULTIPLIER_CIRCUITRY=YES, MAXIMIZE_SPEED=5",
        lpm_pipeline => 2
    )
    PORT MAP (
        dataa => prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im3_a0,
        datab => prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im3_b0,
        clken => VCC_q(0),
        aclr => prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im3_reset,
        clock => clk,
        result => prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im3_s1
    );
    prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im3_q <= prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im3_s1;

    -- prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_align_13(BITSHIFT,985)@2
    prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_align_13_qint <= prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im3_q & "000000000000000000";
    prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_align_13_q <= prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_align_13_qint(41 downto 0);

    -- prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im9(MULT,981)@0 + 2
    prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im9_a0 <= prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_bs1_merged_bit_select_c;
    prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im9_b0 <= prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_bs2_merged_bit_select_c;
    prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im9_reset <= areset;
    prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im9_component : lpm_mult
    GENERIC MAP (
        lpm_widtha => 6,
        lpm_widthb => 6,
        lpm_widthp => 12,
        lpm_widths => 1,
        lpm_type => "LPM_MULT",
        lpm_representation => "UNSIGNED",
        lpm_hint => "DEDICATED_MULTIPLIER_CIRCUITRY=YES, MAXIMIZE_SPEED=5",
        lpm_pipeline => 2
    )
    PORT MAP (
        dataa => prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im9_a0,
        datab => prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im9_b0,
        clken => VCC_q(0),
        aclr => prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im9_reset,
        clock => clk,
        result => prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im9_s1
    );
    prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im9_q <= prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im9_s1;

    -- prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im0(MULT,972)@0 + 2
    prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im0_a0 <= prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_bs1_merged_bit_select_b;
    prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im0_b0 <= prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_bs2_merged_bit_select_b;
    prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im0_reset <= areset;
    prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im0_component : lpm_mult
    GENERIC MAP (
        lpm_widtha => 18,
        lpm_widthb => 18,
        lpm_widthp => 36,
        lpm_widths => 1,
        lpm_type => "LPM_MULT",
        lpm_representation => "UNSIGNED",
        lpm_hint => "DEDICATED_MULTIPLIER_CIRCUITRY=YES, MAXIMIZE_SPEED=5",
        lpm_pipeline => 2
    )
    PORT MAP (
        dataa => prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im0_a0,
        datab => prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im0_b0,
        clken => VCC_q(0),
        aclr => prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im0_reset,
        clock => clk,
        result => prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im0_s1
    );
    prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im0_q <= prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im0_s1;

    -- prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_join_12(BITJOIN,984)@2
    prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_join_12_q <= prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im9_q & prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_im0_q;

    -- prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_result_add_0_0(ADD,989)@2 + 1
    prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_result_add_0_0_a <= STD_LOGIC_VECTOR("0" & prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_join_12_q);
    prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_result_add_0_0_b <= STD_LOGIC_VECTOR("0000000" & prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_align_13_q);
    prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_result_add_0_0_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_result_add_0_0_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_result_add_0_0_o <= STD_LOGIC_VECTOR(UNSIGNED(prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_result_add_0_0_a) + UNSIGNED(prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_result_add_0_0_b));
        END IF;
    END PROCESS;
    prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_result_add_0_0_q <= prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_result_add_0_0_o(48 downto 0);

    -- prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_result_add_1_0(ADD,990)@3
    prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_result_add_1_0_a <= STD_LOGIC_VECTOR("0" & prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_result_add_0_0_q);
    prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_result_add_1_0_b <= STD_LOGIC_VECTOR("00000000" & prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_align_15_q);
    prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_result_add_1_0_o <= STD_LOGIC_VECTOR(UNSIGNED(prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_result_add_1_0_a) + UNSIGNED(prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_result_add_1_0_b));
    prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_result_add_1_0_q <= prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_result_add_1_0_o(49 downto 0);

    -- osig_uid704_prod_uid151_bd_uid7_fpComplexMulTest(BITSELECT,703)@3
    osig_uid704_prod_uid151_bd_uid7_fpComplexMulTest_in <= prodXY_uid703_prod_uid151_bd_uid7_fpComplexMulTest_result_add_1_0_q(47 downto 0);
    osig_uid704_prod_uid151_bd_uid7_fpComplexMulTest_b <= osig_uid704_prod_uid151_bd_uid7_fpComplexMulTest_in(47 downto 0);

    -- redist24_osig_uid704_prod_uid151_bd_uid7_fpComplexMulTest_b_1(DELAY,1105)
    redist24_osig_uid704_prod_uid151_bd_uid7_fpComplexMulTest_b_1 : dspba_delay
    GENERIC MAP ( width => 48, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => osig_uid704_prod_uid151_bd_uid7_fpComplexMulTest_b, xout => redist24_osig_uid704_prod_uid151_bd_uid7_fpComplexMulTest_b_1_q, clk => clk, aclr => areset );

    -- normalizeBit_uid153_bd_uid7_fpComplexMulTest(BITSELECT,152)@4
    normalizeBit_uid153_bd_uid7_fpComplexMulTest_b <= STD_LOGIC_VECTOR(redist24_osig_uid704_prod_uid151_bd_uid7_fpComplexMulTest_b_1_q(47 downto 47));

    -- redist94_normalizeBit_uid153_bd_uid7_fpComplexMulTest_b_1(DELAY,1175)
    redist94_normalizeBit_uid153_bd_uid7_fpComplexMulTest_b_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => normalizeBit_uid153_bd_uid7_fpComplexMulTest_b, xout => redist94_normalizeBit_uid153_bd_uid7_fpComplexMulTest_b_1_q, clk => clk, aclr => areset );

    -- fracRPostNormHigh_uid155_bd_uid7_fpComplexMulTest(BITSELECT,154)@4
    fracRPostNormHigh_uid155_bd_uid7_fpComplexMulTest_in <= redist24_osig_uid704_prod_uid151_bd_uid7_fpComplexMulTest_b_1_q(46 downto 0);
    fracRPostNormHigh_uid155_bd_uid7_fpComplexMulTest_b <= fracRPostNormHigh_uid155_bd_uid7_fpComplexMulTest_in(46 downto 23);

    -- fracRPostNormLow_uid156_bd_uid7_fpComplexMulTest(BITSELECT,155)@4
    fracRPostNormLow_uid156_bd_uid7_fpComplexMulTest_in <= redist24_osig_uid704_prod_uid151_bd_uid7_fpComplexMulTest_b_1_q(45 downto 0);
    fracRPostNormLow_uid156_bd_uid7_fpComplexMulTest_b <= fracRPostNormLow_uid156_bd_uid7_fpComplexMulTest_in(45 downto 22);

    -- fracRPostNorm_uid157_bd_uid7_fpComplexMulTest(MUX,156)@4
    fracRPostNorm_uid157_bd_uid7_fpComplexMulTest_s <= normalizeBit_uid153_bd_uid7_fpComplexMulTest_b;
    fracRPostNorm_uid157_bd_uid7_fpComplexMulTest_combproc: PROCESS (fracRPostNorm_uid157_bd_uid7_fpComplexMulTest_s, fracRPostNormLow_uid156_bd_uid7_fpComplexMulTest_b, fracRPostNormHigh_uid155_bd_uid7_fpComplexMulTest_b)
    BEGIN
        CASE (fracRPostNorm_uid157_bd_uid7_fpComplexMulTest_s) IS
            WHEN "0" => fracRPostNorm_uid157_bd_uid7_fpComplexMulTest_q <= fracRPostNormLow_uid156_bd_uid7_fpComplexMulTest_b;
            WHEN "1" => fracRPostNorm_uid157_bd_uid7_fpComplexMulTest_q <= fracRPostNormHigh_uid155_bd_uid7_fpComplexMulTest_b;
            WHEN OTHERS => fracRPostNorm_uid157_bd_uid7_fpComplexMulTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- fracRPostNorm1dto0_uid165_bd_uid7_fpComplexMulTest(BITSELECT,164)@4
    fracRPostNorm1dto0_uid165_bd_uid7_fpComplexMulTest_in <= fracRPostNorm_uid157_bd_uid7_fpComplexMulTest_q(1 downto 0);
    fracRPostNorm1dto0_uid165_bd_uid7_fpComplexMulTest_b <= fracRPostNorm1dto0_uid165_bd_uid7_fpComplexMulTest_in(1 downto 0);

    -- extraStickyBitOfProd_uid159_bd_uid7_fpComplexMulTest(BITSELECT,158)@4
    extraStickyBitOfProd_uid159_bd_uid7_fpComplexMulTest_in <= STD_LOGIC_VECTOR(redist24_osig_uid704_prod_uid151_bd_uid7_fpComplexMulTest_b_1_q(22 downto 0));
    extraStickyBitOfProd_uid159_bd_uid7_fpComplexMulTest_b <= STD_LOGIC_VECTOR(extraStickyBitOfProd_uid159_bd_uid7_fpComplexMulTest_in(22 downto 22));

    -- extraStickyBit_uid160_bd_uid7_fpComplexMulTest(MUX,159)@4
    extraStickyBit_uid160_bd_uid7_fpComplexMulTest_s <= normalizeBit_uid153_bd_uid7_fpComplexMulTest_b;
    extraStickyBit_uid160_bd_uid7_fpComplexMulTest_combproc: PROCESS (extraStickyBit_uid160_bd_uid7_fpComplexMulTest_s, GND_q, extraStickyBitOfProd_uid159_bd_uid7_fpComplexMulTest_b)
    BEGIN
        CASE (extraStickyBit_uid160_bd_uid7_fpComplexMulTest_s) IS
            WHEN "0" => extraStickyBit_uid160_bd_uid7_fpComplexMulTest_q <= GND_q;
            WHEN "1" => extraStickyBit_uid160_bd_uid7_fpComplexMulTest_q <= extraStickyBitOfProd_uid159_bd_uid7_fpComplexMulTest_b;
            WHEN OTHERS => extraStickyBit_uid160_bd_uid7_fpComplexMulTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- stickyRange_uid158_bd_uid7_fpComplexMulTest(BITSELECT,157)@4
    stickyRange_uid158_bd_uid7_fpComplexMulTest_in <= redist24_osig_uid704_prod_uid151_bd_uid7_fpComplexMulTest_b_1_q(21 downto 0);
    stickyRange_uid158_bd_uid7_fpComplexMulTest_b <= stickyRange_uid158_bd_uid7_fpComplexMulTest_in(21 downto 0);

    -- stickyExtendedRange_uid161_bd_uid7_fpComplexMulTest(BITJOIN,160)@4
    stickyExtendedRange_uid161_bd_uid7_fpComplexMulTest_q <= extraStickyBit_uid160_bd_uid7_fpComplexMulTest_q & stickyRange_uid158_bd_uid7_fpComplexMulTest_b;

    -- stickyRangeComparator_uid163_bd_uid7_fpComplexMulTest(LOGICAL,162)@4
    stickyRangeComparator_uid163_bd_uid7_fpComplexMulTest_q <= "1" WHEN stickyExtendedRange_uid161_bd_uid7_fpComplexMulTest_q = cstZeroWF_uid25_ac_uid6_fpComplexMulTest_q ELSE "0";

    -- sticky_uid164_bd_uid7_fpComplexMulTest(LOGICAL,163)@4
    sticky_uid164_bd_uid7_fpComplexMulTest_q <= not (stickyRangeComparator_uid163_bd_uid7_fpComplexMulTest_q);

    -- lrs_uid166_bd_uid7_fpComplexMulTest(BITJOIN,165)@4
    lrs_uid166_bd_uid7_fpComplexMulTest_q <= fracRPostNorm1dto0_uid165_bd_uid7_fpComplexMulTest_b & sticky_uid164_bd_uid7_fpComplexMulTest_q;

    -- roundBitDetectionPattern_uid168_bd_uid7_fpComplexMulTest(LOGICAL,167)@4 + 1
    roundBitDetectionPattern_uid168_bd_uid7_fpComplexMulTest_qi <= "1" WHEN lrs_uid166_bd_uid7_fpComplexMulTest_q = roundBitDetectionConstant_uid77_ac_uid6_fpComplexMulTest_q ELSE "0";
    roundBitDetectionPattern_uid168_bd_uid7_fpComplexMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => roundBitDetectionPattern_uid168_bd_uid7_fpComplexMulTest_qi, xout => roundBitDetectionPattern_uid168_bd_uid7_fpComplexMulTest_q, clk => clk, aclr => areset );

    -- roundBit_uid169_bd_uid7_fpComplexMulTest(LOGICAL,168)@5
    roundBit_uid169_bd_uid7_fpComplexMulTest_q <= not (roundBitDetectionPattern_uid168_bd_uid7_fpComplexMulTest_q);

    -- roundBitAndNormalizationOp_uid172_bd_uid7_fpComplexMulTest(BITJOIN,171)@5
    roundBitAndNormalizationOp_uid172_bd_uid7_fpComplexMulTest_q <= GND_q & redist94_normalizeBit_uid153_bd_uid7_fpComplexMulTest_b_1_q & cstZeroWF_uid25_ac_uid6_fpComplexMulTest_q & roundBit_uid169_bd_uid7_fpComplexMulTest_q;

    -- expSum_uid148_bd_uid7_fpComplexMulTest(ADD,147)@4
    expSum_uid148_bd_uid7_fpComplexMulTest_a <= STD_LOGIC_VECTOR("0" & redist104_expX_uid110_bd_uid7_fpComplexMulTest_b_4_q);
    expSum_uid148_bd_uid7_fpComplexMulTest_b <= STD_LOGIC_VECTOR("0" & redist103_expY_uid111_bd_uid7_fpComplexMulTest_b_4_q);
    expSum_uid148_bd_uid7_fpComplexMulTest_o <= STD_LOGIC_VECTOR(UNSIGNED(expSum_uid148_bd_uid7_fpComplexMulTest_a) + UNSIGNED(expSum_uid148_bd_uid7_fpComplexMulTest_b));
    expSum_uid148_bd_uid7_fpComplexMulTest_q <= expSum_uid148_bd_uid7_fpComplexMulTest_o(8 downto 0);

    -- expSumMBias_uid150_bd_uid7_fpComplexMulTest(SUB,149)@4 + 1
    expSumMBias_uid150_bd_uid7_fpComplexMulTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & expSum_uid148_bd_uid7_fpComplexMulTest_q));
    expSumMBias_uid150_bd_uid7_fpComplexMulTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((11 downto 10 => biasInc_uid59_ac_uid6_fpComplexMulTest_q(9)) & biasInc_uid59_ac_uid6_fpComplexMulTest_q));
    expSumMBias_uid150_bd_uid7_fpComplexMulTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            expSumMBias_uid150_bd_uid7_fpComplexMulTest_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            expSumMBias_uid150_bd_uid7_fpComplexMulTest_o <= STD_LOGIC_VECTOR(SIGNED(expSumMBias_uid150_bd_uid7_fpComplexMulTest_a) - SIGNED(expSumMBias_uid150_bd_uid7_fpComplexMulTest_b));
        END IF;
    END PROCESS;
    expSumMBias_uid150_bd_uid7_fpComplexMulTest_q <= expSumMBias_uid150_bd_uid7_fpComplexMulTest_o(10 downto 0);

    -- redist93_fracRPostNorm_uid157_bd_uid7_fpComplexMulTest_q_1(DELAY,1174)
    redist93_fracRPostNorm_uid157_bd_uid7_fpComplexMulTest_q_1 : dspba_delay
    GENERIC MAP ( width => 24, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => fracRPostNorm_uid157_bd_uid7_fpComplexMulTest_q, xout => redist93_fracRPostNorm_uid157_bd_uid7_fpComplexMulTest_q_1_q, clk => clk, aclr => areset );

    -- expFracPreRound_uid170_bd_uid7_fpComplexMulTest(BITJOIN,169)@5
    expFracPreRound_uid170_bd_uid7_fpComplexMulTest_q <= expSumMBias_uid150_bd_uid7_fpComplexMulTest_q & redist93_fracRPostNorm_uid157_bd_uid7_fpComplexMulTest_q_1_q;

    -- expFracRPostRounding_uid173_bd_uid7_fpComplexMulTest(ADD,172)@5
    expFracRPostRounding_uid173_bd_uid7_fpComplexMulTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((36 downto 35 => expFracPreRound_uid170_bd_uid7_fpComplexMulTest_q(34)) & expFracPreRound_uid170_bd_uid7_fpComplexMulTest_q));
    expFracRPostRounding_uid173_bd_uid7_fpComplexMulTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("00000000000" & roundBitAndNormalizationOp_uid172_bd_uid7_fpComplexMulTest_q));
    expFracRPostRounding_uid173_bd_uid7_fpComplexMulTest_o <= STD_LOGIC_VECTOR(SIGNED(expFracRPostRounding_uid173_bd_uid7_fpComplexMulTest_a) + SIGNED(expFracRPostRounding_uid173_bd_uid7_fpComplexMulTest_b));
    expFracRPostRounding_uid173_bd_uid7_fpComplexMulTest_q <= expFracRPostRounding_uid173_bd_uid7_fpComplexMulTest_o(35 downto 0);

    -- expRPreExcExt_uid175_bd_uid7_fpComplexMulTest(BITSELECT,174)@5
    expRPreExcExt_uid175_bd_uid7_fpComplexMulTest_b <= STD_LOGIC_VECTOR(expFracRPostRounding_uid173_bd_uid7_fpComplexMulTest_q(35 downto 24));

    -- redist91_expRPreExcExt_uid175_bd_uid7_fpComplexMulTest_b_1(DELAY,1172)
    redist91_expRPreExcExt_uid175_bd_uid7_fpComplexMulTest_b_1 : dspba_delay
    GENERIC MAP ( width => 12, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => expRPreExcExt_uid175_bd_uid7_fpComplexMulTest_b, xout => redist91_expRPreExcExt_uid175_bd_uid7_fpComplexMulTest_b_1_q, clk => clk, aclr => areset );

    -- expOvf_uid179_bd_uid7_fpComplexMulTest(COMPARE,178)@6
    expOvf_uid179_bd_uid7_fpComplexMulTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000000" & cstAllOWE_uid24_ac_uid6_fpComplexMulTest_q));
    expOvf_uid179_bd_uid7_fpComplexMulTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((13 downto 12 => redist91_expRPreExcExt_uid175_bd_uid7_fpComplexMulTest_b_1_q(11)) & redist91_expRPreExcExt_uid175_bd_uid7_fpComplexMulTest_b_1_q));
    expOvf_uid179_bd_uid7_fpComplexMulTest_o <= STD_LOGIC_VECTOR(SIGNED(expOvf_uid179_bd_uid7_fpComplexMulTest_a) - SIGNED(expOvf_uid179_bd_uid7_fpComplexMulTest_b));
    expOvf_uid179_bd_uid7_fpComplexMulTest_c(0) <= expOvf_uid179_bd_uid7_fpComplexMulTest_o(13);

    -- ExcROvfAndInReg_uid188_bd_uid7_fpComplexMulTest(LOGICAL,187)@6
    ExcROvfAndInReg_uid188_bd_uid7_fpComplexMulTest_q <= excR_x_uid127_bd_uid7_fpComplexMulTest_q and excR_y_uid141_bd_uid7_fpComplexMulTest_q and expOvf_uid179_bd_uid7_fpComplexMulTest_c;

    -- excYRAndExcXI_uid187_bd_uid7_fpComplexMulTest(LOGICAL,186)@6
    excYRAndExcXI_uid187_bd_uid7_fpComplexMulTest_q <= excR_y_uid141_bd_uid7_fpComplexMulTest_q and excI_x_uid123_bd_uid7_fpComplexMulTest_q;

    -- excXRAndExcYI_uid186_bd_uid7_fpComplexMulTest(LOGICAL,185)@6
    excXRAndExcYI_uid186_bd_uid7_fpComplexMulTest_q <= excR_x_uid127_bd_uid7_fpComplexMulTest_q and excI_y_uid137_bd_uid7_fpComplexMulTest_q;

    -- excXIAndExcYI_uid185_bd_uid7_fpComplexMulTest(LOGICAL,184)@6
    excXIAndExcYI_uid185_bd_uid7_fpComplexMulTest_q <= excI_x_uid123_bd_uid7_fpComplexMulTest_q and excI_y_uid137_bd_uid7_fpComplexMulTest_q;

    -- excRInf_uid189_bd_uid7_fpComplexMulTest(LOGICAL,188)@6 + 1
    excRInf_uid189_bd_uid7_fpComplexMulTest_qi <= excXIAndExcYI_uid185_bd_uid7_fpComplexMulTest_q or excXRAndExcYI_uid186_bd_uid7_fpComplexMulTest_q or excYRAndExcXI_uid187_bd_uid7_fpComplexMulTest_q or ExcROvfAndInReg_uid188_bd_uid7_fpComplexMulTest_q;
    excRInf_uid189_bd_uid7_fpComplexMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => excRInf_uid189_bd_uid7_fpComplexMulTest_qi, xout => excRInf_uid189_bd_uid7_fpComplexMulTest_q, clk => clk, aclr => areset );

    -- expUdf_uid177_bd_uid7_fpComplexMulTest_cmp_sign(LOGICAL,775)@6
    expUdf_uid177_bd_uid7_fpComplexMulTest_cmp_sign_q <= STD_LOGIC_VECTOR(redist91_expRPreExcExt_uid175_bd_uid7_fpComplexMulTest_b_1_q(11 downto 11));

    -- excZC3_uid183_bd_uid7_fpComplexMulTest(LOGICAL,182)@6
    excZC3_uid183_bd_uid7_fpComplexMulTest_q <= excR_x_uid127_bd_uid7_fpComplexMulTest_q and excR_y_uid141_bd_uid7_fpComplexMulTest_q and expUdf_uid177_bd_uid7_fpComplexMulTest_cmp_sign_q;

    -- excYZAndExcXR_uid182_bd_uid7_fpComplexMulTest(LOGICAL,181)@6
    excYZAndExcXR_uid182_bd_uid7_fpComplexMulTest_q <= redist97_excZ_y_uid133_bd_uid7_fpComplexMulTest_q_2_q and excR_x_uid127_bd_uid7_fpComplexMulTest_q;

    -- excXZAndExcYR_uid181_bd_uid7_fpComplexMulTest(LOGICAL,180)@6
    excXZAndExcYR_uid181_bd_uid7_fpComplexMulTest_q <= redist100_excZ_x_uid119_bd_uid7_fpComplexMulTest_q_2_q and excR_y_uid141_bd_uid7_fpComplexMulTest_q;

    -- excXZAndExcYZ_uid180_bd_uid7_fpComplexMulTest(LOGICAL,179)@6
    excXZAndExcYZ_uid180_bd_uid7_fpComplexMulTest_q <= redist100_excZ_x_uid119_bd_uid7_fpComplexMulTest_q_2_q and redist97_excZ_y_uid133_bd_uid7_fpComplexMulTest_q_2_q;

    -- excRZero_uid184_bd_uid7_fpComplexMulTest(LOGICAL,183)@6 + 1
    excRZero_uid184_bd_uid7_fpComplexMulTest_qi <= excXZAndExcYZ_uid180_bd_uid7_fpComplexMulTest_q or excXZAndExcYR_uid181_bd_uid7_fpComplexMulTest_q or excYZAndExcXR_uid182_bd_uid7_fpComplexMulTest_q or excZC3_uid183_bd_uid7_fpComplexMulTest_q;
    excRZero_uid184_bd_uid7_fpComplexMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => excRZero_uid184_bd_uid7_fpComplexMulTest_qi, xout => excRZero_uid184_bd_uid7_fpComplexMulTest_q, clk => clk, aclr => areset );

    -- concExc_uid194_bd_uid7_fpComplexMulTest(BITJOIN,193)@7
    concExc_uid194_bd_uid7_fpComplexMulTest_q <= excRNaN_uid193_bd_uid7_fpComplexMulTest_q & excRInf_uid189_bd_uid7_fpComplexMulTest_q & excRZero_uid184_bd_uid7_fpComplexMulTest_q;

    -- excREnc_uid195_bd_uid7_fpComplexMulTest(LOOKUP,194)@7
    excREnc_uid195_bd_uid7_fpComplexMulTest_combproc: PROCESS (concExc_uid194_bd_uid7_fpComplexMulTest_q)
    BEGIN
        -- Begin reserved scope level
        CASE (concExc_uid194_bd_uid7_fpComplexMulTest_q) IS
            WHEN "000" => excREnc_uid195_bd_uid7_fpComplexMulTest_q <= "01";
            WHEN "001" => excREnc_uid195_bd_uid7_fpComplexMulTest_q <= "00";
            WHEN "010" => excREnc_uid195_bd_uid7_fpComplexMulTest_q <= "10";
            WHEN "011" => excREnc_uid195_bd_uid7_fpComplexMulTest_q <= "00";
            WHEN "100" => excREnc_uid195_bd_uid7_fpComplexMulTest_q <= "11";
            WHEN "101" => excREnc_uid195_bd_uid7_fpComplexMulTest_q <= "00";
            WHEN "110" => excREnc_uid195_bd_uid7_fpComplexMulTest_q <= "00";
            WHEN "111" => excREnc_uid195_bd_uid7_fpComplexMulTest_q <= "00";
            WHEN OTHERS => -- unreachable
                           excREnc_uid195_bd_uid7_fpComplexMulTest_q <= (others => '-');
        END CASE;
        -- End reserved scope level
    END PROCESS;

    -- invExcRNaN_uid196_bd_uid7_fpComplexMulTest(LOGICAL,195)@7
    invExcRNaN_uid196_bd_uid7_fpComplexMulTest_q <= not (excRNaN_uid193_bd_uid7_fpComplexMulTest_q);

    -- signR_uid152_bd_uid7_fpComplexMulTest(LOGICAL,151)@6 + 1
    signR_uid152_bd_uid7_fpComplexMulTest_qi <= redist102_signX_uid112_bd_uid7_fpComplexMulTest_b_6_q xor redist101_signY_uid113_bd_uid7_fpComplexMulTest_b_6_q;
    signR_uid152_bd_uid7_fpComplexMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => signR_uid152_bd_uid7_fpComplexMulTest_qi, xout => signR_uid152_bd_uid7_fpComplexMulTest_q, clk => clk, aclr => areset );

    -- signRPostExc_uid197_bd_uid7_fpComplexMulTest(LOGICAL,196)@7
    signRPostExc_uid197_bd_uid7_fpComplexMulTest_q <= signR_uid152_bd_uid7_fpComplexMulTest_q and invExcRNaN_uid196_bd_uid7_fpComplexMulTest_q;

    -- expRPreExc_uid176_bd_uid7_fpComplexMulTest(BITSELECT,175)@6
    expRPreExc_uid176_bd_uid7_fpComplexMulTest_in <= redist91_expRPreExcExt_uid175_bd_uid7_fpComplexMulTest_b_1_q(7 downto 0);
    expRPreExc_uid176_bd_uid7_fpComplexMulTest_b <= expRPreExc_uid176_bd_uid7_fpComplexMulTest_in(7 downto 0);

    -- redist90_expRPreExc_uid176_bd_uid7_fpComplexMulTest_b_1(DELAY,1171)
    redist90_expRPreExc_uid176_bd_uid7_fpComplexMulTest_b_1 : dspba_delay
    GENERIC MAP ( width => 8, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => expRPreExc_uid176_bd_uid7_fpComplexMulTest_b, xout => redist90_expRPreExc_uid176_bd_uid7_fpComplexMulTest_b_1_q, clk => clk, aclr => areset );

    -- fracRPreExc_uid174_bd_uid7_fpComplexMulTest(BITSELECT,173)@5
    fracRPreExc_uid174_bd_uid7_fpComplexMulTest_in <= expFracRPostRounding_uid173_bd_uid7_fpComplexMulTest_q(23 downto 0);
    fracRPreExc_uid174_bd_uid7_fpComplexMulTest_b <= fracRPreExc_uid174_bd_uid7_fpComplexMulTest_in(23 downto 1);

    -- redist92_fracRPreExc_uid174_bd_uid7_fpComplexMulTest_b_2(DELAY,1173)
    redist92_fracRPreExc_uid174_bd_uid7_fpComplexMulTest_b_2 : dspba_delay
    GENERIC MAP ( width => 23, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => fracRPreExc_uid174_bd_uid7_fpComplexMulTest_b, xout => redist92_fracRPreExc_uid174_bd_uid7_fpComplexMulTest_b_2_q, clk => clk, aclr => areset );

    -- R_uid198_bd_uid7_fpComplexMulTest(BITJOIN,197)@7
    R_uid198_bd_uid7_fpComplexMulTest_q <= excREnc_uid195_bd_uid7_fpComplexMulTest_q & signRPostExc_uid197_bd_uid7_fpComplexMulTest_q & redist90_expRPreExc_uid176_bd_uid7_fpComplexMulTest_b_1_q & redist92_fracRPreExc_uid174_bd_uid7_fpComplexMulTest_b_2_q;

    -- excBits_uid11_fpComplexMulTest(BITSELECT,10)@7
    excBits_uid11_fpComplexMulTest_b <= R_uid198_bd_uid7_fpComplexMulTest_q(33 downto 32);

    -- ySign_uid10_fpComplexMulTest(BITSELECT,9)@7
    ySign_uid10_fpComplexMulTest_b <= STD_LOGIC_VECTOR(R_uid198_bd_uid7_fpComplexMulTest_q(31 downto 31));

    -- invYSign_uid14_fpComplexMulTest(LOGICAL,13)@7
    invYSign_uid14_fpComplexMulTest_q <= not (ySign_uid10_fpComplexMulTest_b);

    -- exp_uid13_fpComplexMulTest(BITSELECT,12)@7
    exp_uid13_fpComplexMulTest_b <= R_uid198_bd_uid7_fpComplexMulTest_q(30 downto 23);

    -- fraction_uid12_fpComplexMulTest(BITSELECT,11)@7
    fraction_uid12_fpComplexMulTest_b <= R_uid198_bd_uid7_fpComplexMulTest_q(22 downto 0);

    -- minusY_uid15_fpComplexMulTest(BITJOIN,14)@7
    minusY_uid15_fpComplexMulTest_q <= excBits_uid11_fpComplexMulTest_b & invYSign_uid14_fpComplexMulTest_q & exp_uid13_fpComplexMulTest_b & fraction_uid12_fpComplexMulTest_b;

    -- sigY_uid416_rReal_uid16_fpComplexMulTest(BITSELECT,415)@7
    sigY_uid416_rReal_uid16_fpComplexMulTest_in <= STD_LOGIC_VECTOR(minusY_uid15_fpComplexMulTest_q(31 downto 0));
    sigY_uid416_rReal_uid16_fpComplexMulTest_b <= STD_LOGIC_VECTOR(sigY_uid416_rReal_uid16_fpComplexMulTest_in(31 downto 31));

    -- redist74_sigY_uid416_rReal_uid16_fpComplexMulTest_b_1(DELAY,1155)
    redist74_sigY_uid416_rReal_uid16_fpComplexMulTest_b_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => sigY_uid416_rReal_uid16_fpComplexMulTest_b, xout => redist74_sigY_uid416_rReal_uid16_fpComplexMulTest_b_1_q, clk => clk, aclr => areset );

    -- expY_uid415_rReal_uid16_fpComplexMulTest(BITSELECT,414)@7
    expY_uid415_rReal_uid16_fpComplexMulTest_in <= minusY_uid15_fpComplexMulTest_q(30 downto 0);
    expY_uid415_rReal_uid16_fpComplexMulTest_b <= expY_uid415_rReal_uid16_fpComplexMulTest_in(30 downto 23);

    -- redist75_expY_uid415_rReal_uid16_fpComplexMulTest_b_1(DELAY,1156)
    redist75_expY_uid415_rReal_uid16_fpComplexMulTest_b_1 : dspba_delay
    GENERIC MAP ( width => 8, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => expY_uid415_rReal_uid16_fpComplexMulTest_b, xout => redist75_expY_uid415_rReal_uid16_fpComplexMulTest_b_1_q, clk => clk, aclr => areset );

    -- fracY_uid414_rReal_uid16_fpComplexMulTest(BITSELECT,413)@7
    fracY_uid414_rReal_uid16_fpComplexMulTest_in <= minusY_uid15_fpComplexMulTest_q(22 downto 0);
    fracY_uid414_rReal_uid16_fpComplexMulTest_b <= fracY_uid414_rReal_uid16_fpComplexMulTest_in(22 downto 0);

    -- redist76_fracY_uid414_rReal_uid16_fpComplexMulTest_b_1(DELAY,1157)
    redist76_fracY_uid414_rReal_uid16_fpComplexMulTest_b_1 : dspba_delay
    GENERIC MAP ( width => 23, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => fracY_uid414_rReal_uid16_fpComplexMulTest_b, xout => redist76_fracY_uid414_rReal_uid16_fpComplexMulTest_b_1_q, clk => clk, aclr => areset );

    -- ypn_uid417_rReal_uid16_fpComplexMulTest(BITJOIN,416)@8
    ypn_uid417_rReal_uid16_fpComplexMulTest_q <= redist74_sigY_uid416_rReal_uid16_fpComplexMulTest_b_1_q & redist75_expY_uid415_rReal_uid16_fpComplexMulTest_b_1_q & redist76_fracY_uid414_rReal_uid16_fpComplexMulTest_b_1_q;

    -- excYZAndExcXI_uid100_ac_uid6_fpComplexMulTest(LOGICAL,99)@6
    excYZAndExcXI_uid100_ac_uid6_fpComplexMulTest_q <= redist113_excZ_y_uid43_ac_uid6_fpComplexMulTest_q_2_q and excI_x_uid33_ac_uid6_fpComplexMulTest_q;

    -- excXZAndExcYI_uid101_ac_uid6_fpComplexMulTest(LOGICAL,100)@6
    excXZAndExcYI_uid101_ac_uid6_fpComplexMulTest_q <= redist116_excZ_x_uid29_ac_uid6_fpComplexMulTest_q_2_q and excI_y_uid47_ac_uid6_fpComplexMulTest_q;

    -- ZeroTimesInf_uid102_ac_uid6_fpComplexMulTest(LOGICAL,101)@6
    ZeroTimesInf_uid102_ac_uid6_fpComplexMulTest_q <= excXZAndExcYI_uid101_ac_uid6_fpComplexMulTest_q or excYZAndExcXI_uid100_ac_uid6_fpComplexMulTest_q;

    -- excRNaN_uid103_ac_uid6_fpComplexMulTest(LOGICAL,102)@6 + 1
    excRNaN_uid103_ac_uid6_fpComplexMulTest_qi <= excN_x_uid34_ac_uid6_fpComplexMulTest_q or excN_y_uid48_ac_uid6_fpComplexMulTest_q or ZeroTimesInf_uid102_ac_uid6_fpComplexMulTest_q;
    excRNaN_uid103_ac_uid6_fpComplexMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => excRNaN_uid103_ac_uid6_fpComplexMulTest_qi, xout => excRNaN_uid103_ac_uid6_fpComplexMulTest_q, clk => clk, aclr => areset );

    -- prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im6(MULT,959)@1 + 2
    prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im6_a0 <= redist12_prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_bs2_merged_bit_select_b_1_q;
    prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im6_b0 <= redist13_prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_bs1_merged_bit_select_c_1_q;
    prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im6_reset <= areset;
    prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im6_component : lpm_mult
    GENERIC MAP (
        lpm_widtha => 18,
        lpm_widthb => 6,
        lpm_widthp => 24,
        lpm_widths => 1,
        lpm_type => "LPM_MULT",
        lpm_representation => "UNSIGNED",
        lpm_hint => "DEDICATED_MULTIPLIER_CIRCUITRY=YES, MAXIMIZE_SPEED=5",
        lpm_pipeline => 2
    )
    PORT MAP (
        dataa => prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im6_a0,
        datab => prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im6_b0,
        clken => VCC_q(0),
        aclr => prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im6_reset,
        clock => clk,
        result => prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im6_s1
    );
    prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im6_q <= prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im6_s1;

    -- prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_align_15(BITSHIFT,968)@3
    prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_align_15_qint <= prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im6_q & "000000000000000000";
    prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_align_15_q <= prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_align_15_qint(41 downto 0);

    -- prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im3(MULT,956)@0 + 2
    prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im3_a0 <= prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_bs1_merged_bit_select_b;
    prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im3_b0 <= prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_bs2_merged_bit_select_c;
    prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im3_reset <= areset;
    prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im3_component : lpm_mult
    GENERIC MAP (
        lpm_widtha => 18,
        lpm_widthb => 6,
        lpm_widthp => 24,
        lpm_widths => 1,
        lpm_type => "LPM_MULT",
        lpm_representation => "UNSIGNED",
        lpm_hint => "DEDICATED_MULTIPLIER_CIRCUITRY=YES, MAXIMIZE_SPEED=5",
        lpm_pipeline => 2
    )
    PORT MAP (
        dataa => prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im3_a0,
        datab => prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im3_b0,
        clken => VCC_q(0),
        aclr => prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im3_reset,
        clock => clk,
        result => prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im3_s1
    );
    prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im3_q <= prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im3_s1;

    -- prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_align_13(BITSHIFT,966)@2
    prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_align_13_qint <= prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im3_q & "000000000000000000";
    prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_align_13_q <= prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_align_13_qint(41 downto 0);

    -- prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im9(MULT,962)@0 + 2
    prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im9_a0 <= prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_bs1_merged_bit_select_c;
    prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im9_b0 <= prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_bs2_merged_bit_select_c;
    prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im9_reset <= areset;
    prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im9_component : lpm_mult
    GENERIC MAP (
        lpm_widtha => 6,
        lpm_widthb => 6,
        lpm_widthp => 12,
        lpm_widths => 1,
        lpm_type => "LPM_MULT",
        lpm_representation => "UNSIGNED",
        lpm_hint => "DEDICATED_MULTIPLIER_CIRCUITRY=YES, MAXIMIZE_SPEED=5",
        lpm_pipeline => 2
    )
    PORT MAP (
        dataa => prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im9_a0,
        datab => prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im9_b0,
        clken => VCC_q(0),
        aclr => prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im9_reset,
        clock => clk,
        result => prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im9_s1
    );
    prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im9_q <= prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im9_s1;

    -- prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im0(MULT,953)@0 + 2
    prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im0_a0 <= prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_bs1_merged_bit_select_b;
    prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im0_b0 <= prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_bs2_merged_bit_select_b;
    prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im0_reset <= areset;
    prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im0_component : lpm_mult
    GENERIC MAP (
        lpm_widtha => 18,
        lpm_widthb => 18,
        lpm_widthp => 36,
        lpm_widths => 1,
        lpm_type => "LPM_MULT",
        lpm_representation => "UNSIGNED",
        lpm_hint => "DEDICATED_MULTIPLIER_CIRCUITRY=YES, MAXIMIZE_SPEED=5",
        lpm_pipeline => 2
    )
    PORT MAP (
        dataa => prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im0_a0,
        datab => prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im0_b0,
        clken => VCC_q(0),
        aclr => prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im0_reset,
        clock => clk,
        result => prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im0_s1
    );
    prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im0_q <= prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im0_s1;

    -- prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_join_12(BITJOIN,965)@2
    prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_join_12_q <= prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im9_q & prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_im0_q;

    -- prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_result_add_0_0(ADD,970)@2 + 1
    prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_result_add_0_0_a <= STD_LOGIC_VECTOR("0" & prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_join_12_q);
    prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_result_add_0_0_b <= STD_LOGIC_VECTOR("0000000" & prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_align_13_q);
    prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_result_add_0_0_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_result_add_0_0_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_result_add_0_0_o <= STD_LOGIC_VECTOR(UNSIGNED(prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_result_add_0_0_a) + UNSIGNED(prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_result_add_0_0_b));
        END IF;
    END PROCESS;
    prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_result_add_0_0_q <= prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_result_add_0_0_o(48 downto 0);

    -- prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_result_add_1_0(ADD,971)@3
    prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_result_add_1_0_a <= STD_LOGIC_VECTOR("0" & prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_result_add_0_0_q);
    prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_result_add_1_0_b <= STD_LOGIC_VECTOR("00000000" & prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_align_15_q);
    prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_result_add_1_0_o <= STD_LOGIC_VECTOR(UNSIGNED(prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_result_add_1_0_a) + UNSIGNED(prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_result_add_1_0_b));
    prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_result_add_1_0_q <= prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_result_add_1_0_o(49 downto 0);

    -- osig_uid701_prod_uid61_ac_uid6_fpComplexMulTest(BITSELECT,700)@3
    osig_uid701_prod_uid61_ac_uid6_fpComplexMulTest_in <= prodXY_uid700_prod_uid61_ac_uid6_fpComplexMulTest_result_add_1_0_q(47 downto 0);
    osig_uid701_prod_uid61_ac_uid6_fpComplexMulTest_b <= osig_uid701_prod_uid61_ac_uid6_fpComplexMulTest_in(47 downto 0);

    -- redist25_osig_uid701_prod_uid61_ac_uid6_fpComplexMulTest_b_1(DELAY,1106)
    redist25_osig_uid701_prod_uid61_ac_uid6_fpComplexMulTest_b_1 : dspba_delay
    GENERIC MAP ( width => 48, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => osig_uid701_prod_uid61_ac_uid6_fpComplexMulTest_b, xout => redist25_osig_uid701_prod_uid61_ac_uid6_fpComplexMulTest_b_1_q, clk => clk, aclr => areset );

    -- normalizeBit_uid63_ac_uid6_fpComplexMulTest(BITSELECT,62)@4
    normalizeBit_uid63_ac_uid6_fpComplexMulTest_b <= STD_LOGIC_VECTOR(redist25_osig_uid701_prod_uid61_ac_uid6_fpComplexMulTest_b_1_q(47 downto 47));

    -- redist110_normalizeBit_uid63_ac_uid6_fpComplexMulTest_b_1(DELAY,1191)
    redist110_normalizeBit_uid63_ac_uid6_fpComplexMulTest_b_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => normalizeBit_uid63_ac_uid6_fpComplexMulTest_b, xout => redist110_normalizeBit_uid63_ac_uid6_fpComplexMulTest_b_1_q, clk => clk, aclr => areset );

    -- fracRPostNormHigh_uid65_ac_uid6_fpComplexMulTest(BITSELECT,64)@4
    fracRPostNormHigh_uid65_ac_uid6_fpComplexMulTest_in <= redist25_osig_uid701_prod_uid61_ac_uid6_fpComplexMulTest_b_1_q(46 downto 0);
    fracRPostNormHigh_uid65_ac_uid6_fpComplexMulTest_b <= fracRPostNormHigh_uid65_ac_uid6_fpComplexMulTest_in(46 downto 23);

    -- fracRPostNormLow_uid66_ac_uid6_fpComplexMulTest(BITSELECT,65)@4
    fracRPostNormLow_uid66_ac_uid6_fpComplexMulTest_in <= redist25_osig_uid701_prod_uid61_ac_uid6_fpComplexMulTest_b_1_q(45 downto 0);
    fracRPostNormLow_uid66_ac_uid6_fpComplexMulTest_b <= fracRPostNormLow_uid66_ac_uid6_fpComplexMulTest_in(45 downto 22);

    -- fracRPostNorm_uid67_ac_uid6_fpComplexMulTest(MUX,66)@4
    fracRPostNorm_uid67_ac_uid6_fpComplexMulTest_s <= normalizeBit_uid63_ac_uid6_fpComplexMulTest_b;
    fracRPostNorm_uid67_ac_uid6_fpComplexMulTest_combproc: PROCESS (fracRPostNorm_uid67_ac_uid6_fpComplexMulTest_s, fracRPostNormLow_uid66_ac_uid6_fpComplexMulTest_b, fracRPostNormHigh_uid65_ac_uid6_fpComplexMulTest_b)
    BEGIN
        CASE (fracRPostNorm_uid67_ac_uid6_fpComplexMulTest_s) IS
            WHEN "0" => fracRPostNorm_uid67_ac_uid6_fpComplexMulTest_q <= fracRPostNormLow_uid66_ac_uid6_fpComplexMulTest_b;
            WHEN "1" => fracRPostNorm_uid67_ac_uid6_fpComplexMulTest_q <= fracRPostNormHigh_uid65_ac_uid6_fpComplexMulTest_b;
            WHEN OTHERS => fracRPostNorm_uid67_ac_uid6_fpComplexMulTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- fracRPostNorm1dto0_uid75_ac_uid6_fpComplexMulTest(BITSELECT,74)@4
    fracRPostNorm1dto0_uid75_ac_uid6_fpComplexMulTest_in <= fracRPostNorm_uid67_ac_uid6_fpComplexMulTest_q(1 downto 0);
    fracRPostNorm1dto0_uid75_ac_uid6_fpComplexMulTest_b <= fracRPostNorm1dto0_uid75_ac_uid6_fpComplexMulTest_in(1 downto 0);

    -- extraStickyBitOfProd_uid69_ac_uid6_fpComplexMulTest(BITSELECT,68)@4
    extraStickyBitOfProd_uid69_ac_uid6_fpComplexMulTest_in <= STD_LOGIC_VECTOR(redist25_osig_uid701_prod_uid61_ac_uid6_fpComplexMulTest_b_1_q(22 downto 0));
    extraStickyBitOfProd_uid69_ac_uid6_fpComplexMulTest_b <= STD_LOGIC_VECTOR(extraStickyBitOfProd_uid69_ac_uid6_fpComplexMulTest_in(22 downto 22));

    -- extraStickyBit_uid70_ac_uid6_fpComplexMulTest(MUX,69)@4
    extraStickyBit_uid70_ac_uid6_fpComplexMulTest_s <= normalizeBit_uid63_ac_uid6_fpComplexMulTest_b;
    extraStickyBit_uid70_ac_uid6_fpComplexMulTest_combproc: PROCESS (extraStickyBit_uid70_ac_uid6_fpComplexMulTest_s, GND_q, extraStickyBitOfProd_uid69_ac_uid6_fpComplexMulTest_b)
    BEGIN
        CASE (extraStickyBit_uid70_ac_uid6_fpComplexMulTest_s) IS
            WHEN "0" => extraStickyBit_uid70_ac_uid6_fpComplexMulTest_q <= GND_q;
            WHEN "1" => extraStickyBit_uid70_ac_uid6_fpComplexMulTest_q <= extraStickyBitOfProd_uid69_ac_uid6_fpComplexMulTest_b;
            WHEN OTHERS => extraStickyBit_uid70_ac_uid6_fpComplexMulTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- stickyRange_uid68_ac_uid6_fpComplexMulTest(BITSELECT,67)@4
    stickyRange_uid68_ac_uid6_fpComplexMulTest_in <= redist25_osig_uid701_prod_uid61_ac_uid6_fpComplexMulTest_b_1_q(21 downto 0);
    stickyRange_uid68_ac_uid6_fpComplexMulTest_b <= stickyRange_uid68_ac_uid6_fpComplexMulTest_in(21 downto 0);

    -- stickyExtendedRange_uid71_ac_uid6_fpComplexMulTest(BITJOIN,70)@4
    stickyExtendedRange_uid71_ac_uid6_fpComplexMulTest_q <= extraStickyBit_uid70_ac_uid6_fpComplexMulTest_q & stickyRange_uid68_ac_uid6_fpComplexMulTest_b;

    -- stickyRangeComparator_uid73_ac_uid6_fpComplexMulTest(LOGICAL,72)@4
    stickyRangeComparator_uid73_ac_uid6_fpComplexMulTest_q <= "1" WHEN stickyExtendedRange_uid71_ac_uid6_fpComplexMulTest_q = cstZeroWF_uid25_ac_uid6_fpComplexMulTest_q ELSE "0";

    -- sticky_uid74_ac_uid6_fpComplexMulTest(LOGICAL,73)@4
    sticky_uid74_ac_uid6_fpComplexMulTest_q <= not (stickyRangeComparator_uid73_ac_uid6_fpComplexMulTest_q);

    -- lrs_uid76_ac_uid6_fpComplexMulTest(BITJOIN,75)@4
    lrs_uid76_ac_uid6_fpComplexMulTest_q <= fracRPostNorm1dto0_uid75_ac_uid6_fpComplexMulTest_b & sticky_uid74_ac_uid6_fpComplexMulTest_q;

    -- roundBitDetectionPattern_uid78_ac_uid6_fpComplexMulTest(LOGICAL,77)@4 + 1
    roundBitDetectionPattern_uid78_ac_uid6_fpComplexMulTest_qi <= "1" WHEN lrs_uid76_ac_uid6_fpComplexMulTest_q = roundBitDetectionConstant_uid77_ac_uid6_fpComplexMulTest_q ELSE "0";
    roundBitDetectionPattern_uid78_ac_uid6_fpComplexMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => roundBitDetectionPattern_uid78_ac_uid6_fpComplexMulTest_qi, xout => roundBitDetectionPattern_uid78_ac_uid6_fpComplexMulTest_q, clk => clk, aclr => areset );

    -- roundBit_uid79_ac_uid6_fpComplexMulTest(LOGICAL,78)@5
    roundBit_uid79_ac_uid6_fpComplexMulTest_q <= not (roundBitDetectionPattern_uid78_ac_uid6_fpComplexMulTest_q);

    -- roundBitAndNormalizationOp_uid82_ac_uid6_fpComplexMulTest(BITJOIN,81)@5
    roundBitAndNormalizationOp_uid82_ac_uid6_fpComplexMulTest_q <= GND_q & redist110_normalizeBit_uid63_ac_uid6_fpComplexMulTest_b_1_q & cstZeroWF_uid25_ac_uid6_fpComplexMulTest_q & roundBit_uid79_ac_uid6_fpComplexMulTest_q;

    -- expSum_uid58_ac_uid6_fpComplexMulTest(ADD,57)@4
    expSum_uid58_ac_uid6_fpComplexMulTest_a <= STD_LOGIC_VECTOR("0" & redist120_expX_uid20_ac_uid6_fpComplexMulTest_b_4_q);
    expSum_uid58_ac_uid6_fpComplexMulTest_b <= STD_LOGIC_VECTOR("0" & redist119_expY_uid21_ac_uid6_fpComplexMulTest_b_4_q);
    expSum_uid58_ac_uid6_fpComplexMulTest_o <= STD_LOGIC_VECTOR(UNSIGNED(expSum_uid58_ac_uid6_fpComplexMulTest_a) + UNSIGNED(expSum_uid58_ac_uid6_fpComplexMulTest_b));
    expSum_uid58_ac_uid6_fpComplexMulTest_q <= expSum_uid58_ac_uid6_fpComplexMulTest_o(8 downto 0);

    -- expSumMBias_uid60_ac_uid6_fpComplexMulTest(SUB,59)@4 + 1
    expSumMBias_uid60_ac_uid6_fpComplexMulTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & expSum_uid58_ac_uid6_fpComplexMulTest_q));
    expSumMBias_uid60_ac_uid6_fpComplexMulTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((11 downto 10 => biasInc_uid59_ac_uid6_fpComplexMulTest_q(9)) & biasInc_uid59_ac_uid6_fpComplexMulTest_q));
    expSumMBias_uid60_ac_uid6_fpComplexMulTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            expSumMBias_uid60_ac_uid6_fpComplexMulTest_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            expSumMBias_uid60_ac_uid6_fpComplexMulTest_o <= STD_LOGIC_VECTOR(SIGNED(expSumMBias_uid60_ac_uid6_fpComplexMulTest_a) - SIGNED(expSumMBias_uid60_ac_uid6_fpComplexMulTest_b));
        END IF;
    END PROCESS;
    expSumMBias_uid60_ac_uid6_fpComplexMulTest_q <= expSumMBias_uid60_ac_uid6_fpComplexMulTest_o(10 downto 0);

    -- redist109_fracRPostNorm_uid67_ac_uid6_fpComplexMulTest_q_1(DELAY,1190)
    redist109_fracRPostNorm_uid67_ac_uid6_fpComplexMulTest_q_1 : dspba_delay
    GENERIC MAP ( width => 24, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => fracRPostNorm_uid67_ac_uid6_fpComplexMulTest_q, xout => redist109_fracRPostNorm_uid67_ac_uid6_fpComplexMulTest_q_1_q, clk => clk, aclr => areset );

    -- expFracPreRound_uid80_ac_uid6_fpComplexMulTest(BITJOIN,79)@5
    expFracPreRound_uid80_ac_uid6_fpComplexMulTest_q <= expSumMBias_uid60_ac_uid6_fpComplexMulTest_q & redist109_fracRPostNorm_uid67_ac_uid6_fpComplexMulTest_q_1_q;

    -- expFracRPostRounding_uid83_ac_uid6_fpComplexMulTest(ADD,82)@5
    expFracRPostRounding_uid83_ac_uid6_fpComplexMulTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((36 downto 35 => expFracPreRound_uid80_ac_uid6_fpComplexMulTest_q(34)) & expFracPreRound_uid80_ac_uid6_fpComplexMulTest_q));
    expFracRPostRounding_uid83_ac_uid6_fpComplexMulTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("00000000000" & roundBitAndNormalizationOp_uid82_ac_uid6_fpComplexMulTest_q));
    expFracRPostRounding_uid83_ac_uid6_fpComplexMulTest_o <= STD_LOGIC_VECTOR(SIGNED(expFracRPostRounding_uid83_ac_uid6_fpComplexMulTest_a) + SIGNED(expFracRPostRounding_uid83_ac_uid6_fpComplexMulTest_b));
    expFracRPostRounding_uid83_ac_uid6_fpComplexMulTest_q <= expFracRPostRounding_uid83_ac_uid6_fpComplexMulTest_o(35 downto 0);

    -- expRPreExcExt_uid85_ac_uid6_fpComplexMulTest(BITSELECT,84)@5
    expRPreExcExt_uid85_ac_uid6_fpComplexMulTest_b <= STD_LOGIC_VECTOR(expFracRPostRounding_uid83_ac_uid6_fpComplexMulTest_q(35 downto 24));

    -- redist107_expRPreExcExt_uid85_ac_uid6_fpComplexMulTest_b_1(DELAY,1188)
    redist107_expRPreExcExt_uid85_ac_uid6_fpComplexMulTest_b_1 : dspba_delay
    GENERIC MAP ( width => 12, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => expRPreExcExt_uid85_ac_uid6_fpComplexMulTest_b, xout => redist107_expRPreExcExt_uid85_ac_uid6_fpComplexMulTest_b_1_q, clk => clk, aclr => areset );

    -- expOvf_uid89_ac_uid6_fpComplexMulTest(COMPARE,88)@6
    expOvf_uid89_ac_uid6_fpComplexMulTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000000" & cstAllOWE_uid24_ac_uid6_fpComplexMulTest_q));
    expOvf_uid89_ac_uid6_fpComplexMulTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((13 downto 12 => redist107_expRPreExcExt_uid85_ac_uid6_fpComplexMulTest_b_1_q(11)) & redist107_expRPreExcExt_uid85_ac_uid6_fpComplexMulTest_b_1_q));
    expOvf_uid89_ac_uid6_fpComplexMulTest_o <= STD_LOGIC_VECTOR(SIGNED(expOvf_uid89_ac_uid6_fpComplexMulTest_a) - SIGNED(expOvf_uid89_ac_uid6_fpComplexMulTest_b));
    expOvf_uid89_ac_uid6_fpComplexMulTest_c(0) <= expOvf_uid89_ac_uid6_fpComplexMulTest_o(13);

    -- ExcROvfAndInReg_uid98_ac_uid6_fpComplexMulTest(LOGICAL,97)@6
    ExcROvfAndInReg_uid98_ac_uid6_fpComplexMulTest_q <= excR_x_uid37_ac_uid6_fpComplexMulTest_q and excR_y_uid51_ac_uid6_fpComplexMulTest_q and expOvf_uid89_ac_uid6_fpComplexMulTest_c;

    -- excYRAndExcXI_uid97_ac_uid6_fpComplexMulTest(LOGICAL,96)@6
    excYRAndExcXI_uid97_ac_uid6_fpComplexMulTest_q <= excR_y_uid51_ac_uid6_fpComplexMulTest_q and excI_x_uid33_ac_uid6_fpComplexMulTest_q;

    -- excXRAndExcYI_uid96_ac_uid6_fpComplexMulTest(LOGICAL,95)@6
    excXRAndExcYI_uid96_ac_uid6_fpComplexMulTest_q <= excR_x_uid37_ac_uid6_fpComplexMulTest_q and excI_y_uid47_ac_uid6_fpComplexMulTest_q;

    -- excXIAndExcYI_uid95_ac_uid6_fpComplexMulTest(LOGICAL,94)@6
    excXIAndExcYI_uid95_ac_uid6_fpComplexMulTest_q <= excI_x_uid33_ac_uid6_fpComplexMulTest_q and excI_y_uid47_ac_uid6_fpComplexMulTest_q;

    -- excRInf_uid99_ac_uid6_fpComplexMulTest(LOGICAL,98)@6 + 1
    excRInf_uid99_ac_uid6_fpComplexMulTest_qi <= excXIAndExcYI_uid95_ac_uid6_fpComplexMulTest_q or excXRAndExcYI_uid96_ac_uid6_fpComplexMulTest_q or excYRAndExcXI_uid97_ac_uid6_fpComplexMulTest_q or ExcROvfAndInReg_uid98_ac_uid6_fpComplexMulTest_q;
    excRInf_uid99_ac_uid6_fpComplexMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => excRInf_uid99_ac_uid6_fpComplexMulTest_qi, xout => excRInf_uid99_ac_uid6_fpComplexMulTest_q, clk => clk, aclr => areset );

    -- expUdf_uid87_ac_uid6_fpComplexMulTest_cmp_sign(LOGICAL,773)@6
    expUdf_uid87_ac_uid6_fpComplexMulTest_cmp_sign_q <= STD_LOGIC_VECTOR(redist107_expRPreExcExt_uid85_ac_uid6_fpComplexMulTest_b_1_q(11 downto 11));

    -- excZC3_uid93_ac_uid6_fpComplexMulTest(LOGICAL,92)@6
    excZC3_uid93_ac_uid6_fpComplexMulTest_q <= excR_x_uid37_ac_uid6_fpComplexMulTest_q and excR_y_uid51_ac_uid6_fpComplexMulTest_q and expUdf_uid87_ac_uid6_fpComplexMulTest_cmp_sign_q;

    -- excYZAndExcXR_uid92_ac_uid6_fpComplexMulTest(LOGICAL,91)@6
    excYZAndExcXR_uid92_ac_uid6_fpComplexMulTest_q <= redist113_excZ_y_uid43_ac_uid6_fpComplexMulTest_q_2_q and excR_x_uid37_ac_uid6_fpComplexMulTest_q;

    -- excXZAndExcYR_uid91_ac_uid6_fpComplexMulTest(LOGICAL,90)@6
    excXZAndExcYR_uid91_ac_uid6_fpComplexMulTest_q <= redist116_excZ_x_uid29_ac_uid6_fpComplexMulTest_q_2_q and excR_y_uid51_ac_uid6_fpComplexMulTest_q;

    -- excXZAndExcYZ_uid90_ac_uid6_fpComplexMulTest(LOGICAL,89)@6
    excXZAndExcYZ_uid90_ac_uid6_fpComplexMulTest_q <= redist116_excZ_x_uid29_ac_uid6_fpComplexMulTest_q_2_q and redist113_excZ_y_uid43_ac_uid6_fpComplexMulTest_q_2_q;

    -- excRZero_uid94_ac_uid6_fpComplexMulTest(LOGICAL,93)@6 + 1
    excRZero_uid94_ac_uid6_fpComplexMulTest_qi <= excXZAndExcYZ_uid90_ac_uid6_fpComplexMulTest_q or excXZAndExcYR_uid91_ac_uid6_fpComplexMulTest_q or excYZAndExcXR_uid92_ac_uid6_fpComplexMulTest_q or excZC3_uid93_ac_uid6_fpComplexMulTest_q;
    excRZero_uid94_ac_uid6_fpComplexMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => excRZero_uid94_ac_uid6_fpComplexMulTest_qi, xout => excRZero_uid94_ac_uid6_fpComplexMulTest_q, clk => clk, aclr => areset );

    -- concExc_uid104_ac_uid6_fpComplexMulTest(BITJOIN,103)@7
    concExc_uid104_ac_uid6_fpComplexMulTest_q <= excRNaN_uid103_ac_uid6_fpComplexMulTest_q & excRInf_uid99_ac_uid6_fpComplexMulTest_q & excRZero_uid94_ac_uid6_fpComplexMulTest_q;

    -- excREnc_uid105_ac_uid6_fpComplexMulTest(LOOKUP,104)@7
    excREnc_uid105_ac_uid6_fpComplexMulTest_combproc: PROCESS (concExc_uid104_ac_uid6_fpComplexMulTest_q)
    BEGIN
        -- Begin reserved scope level
        CASE (concExc_uid104_ac_uid6_fpComplexMulTest_q) IS
            WHEN "000" => excREnc_uid105_ac_uid6_fpComplexMulTest_q <= "01";
            WHEN "001" => excREnc_uid105_ac_uid6_fpComplexMulTest_q <= "00";
            WHEN "010" => excREnc_uid105_ac_uid6_fpComplexMulTest_q <= "10";
            WHEN "011" => excREnc_uid105_ac_uid6_fpComplexMulTest_q <= "00";
            WHEN "100" => excREnc_uid105_ac_uid6_fpComplexMulTest_q <= "11";
            WHEN "101" => excREnc_uid105_ac_uid6_fpComplexMulTest_q <= "00";
            WHEN "110" => excREnc_uid105_ac_uid6_fpComplexMulTest_q <= "00";
            WHEN "111" => excREnc_uid105_ac_uid6_fpComplexMulTest_q <= "00";
            WHEN OTHERS => -- unreachable
                           excREnc_uid105_ac_uid6_fpComplexMulTest_q <= (others => '-');
        END CASE;
        -- End reserved scope level
    END PROCESS;

    -- invExcRNaN_uid106_ac_uid6_fpComplexMulTest(LOGICAL,105)@7
    invExcRNaN_uid106_ac_uid6_fpComplexMulTest_q <= not (excRNaN_uid103_ac_uid6_fpComplexMulTest_q);

    -- signR_uid62_ac_uid6_fpComplexMulTest(LOGICAL,61)@6 + 1
    signR_uid62_ac_uid6_fpComplexMulTest_qi <= redist118_signX_uid22_ac_uid6_fpComplexMulTest_b_6_q xor redist117_signY_uid23_ac_uid6_fpComplexMulTest_b_6_q;
    signR_uid62_ac_uid6_fpComplexMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => signR_uid62_ac_uid6_fpComplexMulTest_qi, xout => signR_uid62_ac_uid6_fpComplexMulTest_q, clk => clk, aclr => areset );

    -- signRPostExc_uid107_ac_uid6_fpComplexMulTest(LOGICAL,106)@7
    signRPostExc_uid107_ac_uid6_fpComplexMulTest_q <= signR_uid62_ac_uid6_fpComplexMulTest_q and invExcRNaN_uid106_ac_uid6_fpComplexMulTest_q;

    -- expRPreExc_uid86_ac_uid6_fpComplexMulTest(BITSELECT,85)@6
    expRPreExc_uid86_ac_uid6_fpComplexMulTest_in <= redist107_expRPreExcExt_uid85_ac_uid6_fpComplexMulTest_b_1_q(7 downto 0);
    expRPreExc_uid86_ac_uid6_fpComplexMulTest_b <= expRPreExc_uid86_ac_uid6_fpComplexMulTest_in(7 downto 0);

    -- redist106_expRPreExc_uid86_ac_uid6_fpComplexMulTest_b_1(DELAY,1187)
    redist106_expRPreExc_uid86_ac_uid6_fpComplexMulTest_b_1 : dspba_delay
    GENERIC MAP ( width => 8, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => expRPreExc_uid86_ac_uid6_fpComplexMulTest_b, xout => redist106_expRPreExc_uid86_ac_uid6_fpComplexMulTest_b_1_q, clk => clk, aclr => areset );

    -- fracRPreExc_uid84_ac_uid6_fpComplexMulTest(BITSELECT,83)@5
    fracRPreExc_uid84_ac_uid6_fpComplexMulTest_in <= expFracRPostRounding_uid83_ac_uid6_fpComplexMulTest_q(23 downto 0);
    fracRPreExc_uid84_ac_uid6_fpComplexMulTest_b <= fracRPreExc_uid84_ac_uid6_fpComplexMulTest_in(23 downto 1);

    -- redist108_fracRPreExc_uid84_ac_uid6_fpComplexMulTest_b_2(DELAY,1189)
    redist108_fracRPreExc_uid84_ac_uid6_fpComplexMulTest_b_2 : dspba_delay
    GENERIC MAP ( width => 23, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => fracRPreExc_uid84_ac_uid6_fpComplexMulTest_b, xout => redist108_fracRPreExc_uid84_ac_uid6_fpComplexMulTest_b_2_q, clk => clk, aclr => areset );

    -- R_uid108_ac_uid6_fpComplexMulTest(BITJOIN,107)@7
    R_uid108_ac_uid6_fpComplexMulTest_q <= excREnc_uid105_ac_uid6_fpComplexMulTest_q & signRPostExc_uid107_ac_uid6_fpComplexMulTest_q & redist106_expRPreExc_uid86_ac_uid6_fpComplexMulTest_b_1_q & redist108_fracRPreExc_uid84_ac_uid6_fpComplexMulTest_b_2_q;

    -- redist105_R_uid108_ac_uid6_fpComplexMulTest_q_1(DELAY,1186)
    redist105_R_uid108_ac_uid6_fpComplexMulTest_q_1 : dspba_delay
    GENERIC MAP ( width => 34, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => R_uid108_ac_uid6_fpComplexMulTest_q, xout => redist105_R_uid108_ac_uid6_fpComplexMulTest_q_1_q, clk => clk, aclr => areset );

    -- xMuxRange_uid419_rReal_uid16_fpComplexMulTest(BITSELECT,418)@8
    xMuxRange_uid419_rReal_uid16_fpComplexMulTest_in <= redist105_R_uid108_ac_uid6_fpComplexMulTest_q_1_q(31 downto 0);
    xMuxRange_uid419_rReal_uid16_fpComplexMulTest_b <= xMuxRange_uid419_rReal_uid16_fpComplexMulTest_in(31 downto 0);

    -- expFracY_uid409_rReal_uid16_fpComplexMulTest(BITSELECT,408)@7
    expFracY_uid409_rReal_uid16_fpComplexMulTest_in <= minusY_uid15_fpComplexMulTest_q(30 downto 0);
    expFracY_uid409_rReal_uid16_fpComplexMulTest_b <= expFracY_uid409_rReal_uid16_fpComplexMulTest_in(30 downto 0);

    -- expFracX_uid408_rReal_uid16_fpComplexMulTest(BITSELECT,407)@7
    expFracX_uid408_rReal_uid16_fpComplexMulTest_b <= R_uid108_ac_uid6_fpComplexMulTest_q(30 downto 0);

    -- xGTEy_uid410_rReal_uid16_fpComplexMulTest(COMPARE,409)@7 + 1
    xGTEy_uid410_rReal_uid16_fpComplexMulTest_a <= STD_LOGIC_VECTOR("00" & expFracX_uid408_rReal_uid16_fpComplexMulTest_b);
    xGTEy_uid410_rReal_uid16_fpComplexMulTest_b <= STD_LOGIC_VECTOR("00" & expFracY_uid409_rReal_uid16_fpComplexMulTest_b);
    xGTEy_uid410_rReal_uid16_fpComplexMulTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            xGTEy_uid410_rReal_uid16_fpComplexMulTest_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            xGTEy_uid410_rReal_uid16_fpComplexMulTest_o <= STD_LOGIC_VECTOR(UNSIGNED(xGTEy_uid410_rReal_uid16_fpComplexMulTest_a) - UNSIGNED(xGTEy_uid410_rReal_uid16_fpComplexMulTest_b));
        END IF;
    END PROCESS;
    xGTEy_uid410_rReal_uid16_fpComplexMulTest_n(0) <= not (xGTEy_uid410_rReal_uid16_fpComplexMulTest_o(32));

    -- excX_uid399_rReal_uid16_fpComplexMulTest(BITSELECT,398)@7
    excX_uid399_rReal_uid16_fpComplexMulTest_b <= minusY_uid15_fpComplexMulTest_q(33 downto 32);

    -- excXZero_uid404_rReal_uid16_fpComplexMulTest(LOGICAL,403)@7 + 1
    excXZero_uid404_rReal_uid16_fpComplexMulTest_qi <= "1" WHEN excX_uid399_rReal_uid16_fpComplexMulTest_b = zero2b_uid386_rReal_uid16_fpComplexMulTest_q ELSE "0";
    excXZero_uid404_rReal_uid16_fpComplexMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => excXZero_uid404_rReal_uid16_fpComplexMulTest_qi, xout => excXZero_uid404_rReal_uid16_fpComplexMulTest_q, clk => clk, aclr => areset );

    -- xGTEyOrYz_uid411_rReal_uid16_fpComplexMulTest(LOGICAL,410)@8
    xGTEyOrYz_uid411_rReal_uid16_fpComplexMulTest_q <= excXZero_uid404_rReal_uid16_fpComplexMulTest_q or xGTEy_uid410_rReal_uid16_fpComplexMulTest_n;

    -- excX_uid385_rReal_uid16_fpComplexMulTest(BITSELECT,384)@8
    excX_uid385_rReal_uid16_fpComplexMulTest_b <= redist105_R_uid108_ac_uid6_fpComplexMulTest_q_1_q(33 downto 32);

    -- excXZero_uid390_rReal_uid16_fpComplexMulTest(LOGICAL,389)@8
    excXZero_uid390_rReal_uid16_fpComplexMulTest_q <= "1" WHEN excX_uid385_rReal_uid16_fpComplexMulTest_b = zero2b_uid386_rReal_uid16_fpComplexMulTest_q ELSE "0";

    -- invExcXZ_uid412_rReal_uid16_fpComplexMulTest(LOGICAL,411)@8
    invExcXZ_uid412_rReal_uid16_fpComplexMulTest_q <= not (excXZero_uid390_rReal_uid16_fpComplexMulTest_q);

    -- xGTEy_uid413_rReal_uid16_fpComplexMulTest(LOGICAL,412)@8
    xGTEy_uid413_rReal_uid16_fpComplexMulTest_q <= invExcXZ_uid412_rReal_uid16_fpComplexMulTest_q and xGTEyOrYz_uid411_rReal_uid16_fpComplexMulTest_q;

    -- bSig_uid422_rReal_uid16_fpComplexMulTest(MUX,421)@8
    bSig_uid422_rReal_uid16_fpComplexMulTest_s <= xGTEy_uid413_rReal_uid16_fpComplexMulTest_q;
    bSig_uid422_rReal_uid16_fpComplexMulTest_combproc: PROCESS (bSig_uid422_rReal_uid16_fpComplexMulTest_s, xMuxRange_uid419_rReal_uid16_fpComplexMulTest_b, ypn_uid417_rReal_uid16_fpComplexMulTest_q)
    BEGIN
        CASE (bSig_uid422_rReal_uid16_fpComplexMulTest_s) IS
            WHEN "0" => bSig_uid422_rReal_uid16_fpComplexMulTest_q <= xMuxRange_uid419_rReal_uid16_fpComplexMulTest_b;
            WHEN "1" => bSig_uid422_rReal_uid16_fpComplexMulTest_q <= ypn_uid417_rReal_uid16_fpComplexMulTest_q;
            WHEN OTHERS => bSig_uid422_rReal_uid16_fpComplexMulTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- sigB_uid436_rReal_uid16_fpComplexMulTest(BITSELECT,435)@8
    sigB_uid436_rReal_uid16_fpComplexMulTest_b <= STD_LOGIC_VECTOR(bSig_uid422_rReal_uid16_fpComplexMulTest_q(31 downto 31));

    -- redist62_sigB_uid436_rReal_uid16_fpComplexMulTest_b_3(DELAY,1143)
    redist62_sigB_uid436_rReal_uid16_fpComplexMulTest_b_3 : dspba_delay
    GENERIC MAP ( width => 1, depth => 3, reset_kind => "ASYNC" )
    PORT MAP ( xin => sigB_uid436_rReal_uid16_fpComplexMulTest_b, xout => redist62_sigB_uid436_rReal_uid16_fpComplexMulTest_b_3_q, clk => clk, aclr => areset );

    -- aSig_uid421_rReal_uid16_fpComplexMulTest(MUX,420)@8
    aSig_uid421_rReal_uid16_fpComplexMulTest_s <= xGTEy_uid413_rReal_uid16_fpComplexMulTest_q;
    aSig_uid421_rReal_uid16_fpComplexMulTest_combproc: PROCESS (aSig_uid421_rReal_uid16_fpComplexMulTest_s, ypn_uid417_rReal_uid16_fpComplexMulTest_q, xMuxRange_uid419_rReal_uid16_fpComplexMulTest_b)
    BEGIN
        CASE (aSig_uid421_rReal_uid16_fpComplexMulTest_s) IS
            WHEN "0" => aSig_uid421_rReal_uid16_fpComplexMulTest_q <= ypn_uid417_rReal_uid16_fpComplexMulTest_q;
            WHEN "1" => aSig_uid421_rReal_uid16_fpComplexMulTest_q <= xMuxRange_uid419_rReal_uid16_fpComplexMulTest_b;
            WHEN OTHERS => aSig_uid421_rReal_uid16_fpComplexMulTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- sigA_uid435_rReal_uid16_fpComplexMulTest(BITSELECT,434)@8
    sigA_uid435_rReal_uid16_fpComplexMulTest_b <= STD_LOGIC_VECTOR(aSig_uid421_rReal_uid16_fpComplexMulTest_q(31 downto 31));

    -- redist64_sigA_uid435_rReal_uid16_fpComplexMulTest_b_3(DELAY,1145)
    redist64_sigA_uid435_rReal_uid16_fpComplexMulTest_b_3 : dspba_delay
    GENERIC MAP ( width => 1, depth => 3, reset_kind => "ASYNC" )
    PORT MAP ( xin => sigA_uid435_rReal_uid16_fpComplexMulTest_b, xout => redist64_sigA_uid435_rReal_uid16_fpComplexMulTest_b_3_q, clk => clk, aclr => areset );

    -- effSub_uid437_rReal_uid16_fpComplexMulTest(LOGICAL,436)@11
    effSub_uid437_rReal_uid16_fpComplexMulTest_q <= redist64_sigA_uid435_rReal_uid16_fpComplexMulTest_b_3_q xor redist62_sigB_uid436_rReal_uid16_fpComplexMulTest_b_3_q;

    -- excBZ_uid430_rReal_uid16_fpComplexMulTest(MUX,429)@8
    excBZ_uid430_rReal_uid16_fpComplexMulTest_s <= xGTEy_uid413_rReal_uid16_fpComplexMulTest_q;
    excBZ_uid430_rReal_uid16_fpComplexMulTest_combproc: PROCESS (excBZ_uid430_rReal_uid16_fpComplexMulTest_s, excXZero_uid390_rReal_uid16_fpComplexMulTest_q, excXZero_uid404_rReal_uid16_fpComplexMulTest_q)
    BEGIN
        CASE (excBZ_uid430_rReal_uid16_fpComplexMulTest_s) IS
            WHEN "0" => excBZ_uid430_rReal_uid16_fpComplexMulTest_q <= excXZero_uid390_rReal_uid16_fpComplexMulTest_q;
            WHEN "1" => excBZ_uid430_rReal_uid16_fpComplexMulTest_q <= excXZero_uid404_rReal_uid16_fpComplexMulTest_q;
            WHEN OTHERS => excBZ_uid430_rReal_uid16_fpComplexMulTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- expB_uid432_rReal_uid16_fpComplexMulTest(BITSELECT,431)@8
    expB_uid432_rReal_uid16_fpComplexMulTest_in <= bSig_uid422_rReal_uid16_fpComplexMulTest_q(30 downto 0);
    expB_uid432_rReal_uid16_fpComplexMulTest_b <= expB_uid432_rReal_uid16_fpComplexMulTest_in(30 downto 23);

    -- expA_uid431_rReal_uid16_fpComplexMulTest(BITSELECT,430)@8
    expA_uid431_rReal_uid16_fpComplexMulTest_in <= aSig_uid421_rReal_uid16_fpComplexMulTest_q(30 downto 0);
    expA_uid431_rReal_uid16_fpComplexMulTest_b <= expA_uid431_rReal_uid16_fpComplexMulTest_in(30 downto 23);

    -- expAmExpB_uid447_rReal_uid16_fpComplexMulTest(SUB,446)@8 + 1
    expAmExpB_uid447_rReal_uid16_fpComplexMulTest_a <= STD_LOGIC_VECTOR("0" & expA_uid431_rReal_uid16_fpComplexMulTest_b);
    expAmExpB_uid447_rReal_uid16_fpComplexMulTest_b <= STD_LOGIC_VECTOR("0" & expB_uid432_rReal_uid16_fpComplexMulTest_b);
    expAmExpB_uid447_rReal_uid16_fpComplexMulTest_i <= expAmExpB_uid447_rReal_uid16_fpComplexMulTest_a;
    expAmExpB_uid447_rReal_uid16_fpComplexMulTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            expAmExpB_uid447_rReal_uid16_fpComplexMulTest_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (excBZ_uid430_rReal_uid16_fpComplexMulTest_q = "1") THEN
                expAmExpB_uid447_rReal_uid16_fpComplexMulTest_o <= expAmExpB_uid447_rReal_uid16_fpComplexMulTest_i;
            ELSE
                expAmExpB_uid447_rReal_uid16_fpComplexMulTest_o <= STD_LOGIC_VECTOR(UNSIGNED(expAmExpB_uid447_rReal_uid16_fpComplexMulTest_a) - UNSIGNED(expAmExpB_uid447_rReal_uid16_fpComplexMulTest_b));
            END IF;
        END IF;
    END PROCESS;
    expAmExpB_uid447_rReal_uid16_fpComplexMulTest_q <= expAmExpB_uid447_rReal_uid16_fpComplexMulTest_o(8 downto 0);

    -- shiftedOut_uid450_rReal_uid16_fpComplexMulTest(COMPARE,449)@9 + 1
    shiftedOut_uid450_rReal_uid16_fpComplexMulTest_a <= STD_LOGIC_VECTOR("000000" & cWFP2_uid448_rReal_uid16_fpComplexMulTest_q);
    shiftedOut_uid450_rReal_uid16_fpComplexMulTest_b <= STD_LOGIC_VECTOR("00" & expAmExpB_uid447_rReal_uid16_fpComplexMulTest_q);
    shiftedOut_uid450_rReal_uid16_fpComplexMulTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            shiftedOut_uid450_rReal_uid16_fpComplexMulTest_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            shiftedOut_uid450_rReal_uid16_fpComplexMulTest_o <= STD_LOGIC_VECTOR(UNSIGNED(shiftedOut_uid450_rReal_uid16_fpComplexMulTest_a) - UNSIGNED(shiftedOut_uid450_rReal_uid16_fpComplexMulTest_b));
        END IF;
    END PROCESS;
    shiftedOut_uid450_rReal_uid16_fpComplexMulTest_c(0) <= shiftedOut_uid450_rReal_uid16_fpComplexMulTest_o(10);

    -- iShiftedOut_uid454_rReal_uid16_fpComplexMulTest(LOGICAL,453)@10
    iShiftedOut_uid454_rReal_uid16_fpComplexMulTest_q <= not (shiftedOut_uid450_rReal_uid16_fpComplexMulTest_c);

    -- redist69_excBZ_uid430_rReal_uid16_fpComplexMulTest_q_1(DELAY,1150)
    redist69_excBZ_uid430_rReal_uid16_fpComplexMulTest_q_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => excBZ_uid430_rReal_uid16_fpComplexMulTest_q, xout => redist69_excBZ_uid430_rReal_uid16_fpComplexMulTest_q_1_q, clk => clk, aclr => areset );

    -- invExcBZ_uid445_rReal_uid16_fpComplexMulTest(LOGICAL,444)@9
    invExcBZ_uid445_rReal_uid16_fpComplexMulTest_q <= not (redist69_excBZ_uid430_rReal_uid16_fpComplexMulTest_q_1_q);

    -- fracB_uid434_rReal_uid16_fpComplexMulTest(BITSELECT,433)@8
    fracB_uid434_rReal_uid16_fpComplexMulTest_in <= bSig_uid422_rReal_uid16_fpComplexMulTest_q(22 downto 0);
    fracB_uid434_rReal_uid16_fpComplexMulTest_b <= fracB_uid434_rReal_uid16_fpComplexMulTest_in(22 downto 0);

    -- redist66_fracB_uid434_rReal_uid16_fpComplexMulTest_b_1(DELAY,1147)
    redist66_fracB_uid434_rReal_uid16_fpComplexMulTest_b_1 : dspba_delay
    GENERIC MAP ( width => 23, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => fracB_uid434_rReal_uid16_fpComplexMulTest_b, xout => redist66_fracB_uid434_rReal_uid16_fpComplexMulTest_b_1_q, clk => clk, aclr => areset );

    -- fracBz_uid443_rReal_uid16_fpComplexMulTest(MUX,442)@9
    fracBz_uid443_rReal_uid16_fpComplexMulTest_s <= redist69_excBZ_uid430_rReal_uid16_fpComplexMulTest_q_1_q;
    fracBz_uid443_rReal_uid16_fpComplexMulTest_combproc: PROCESS (fracBz_uid443_rReal_uid16_fpComplexMulTest_s, redist66_fracB_uid434_rReal_uid16_fpComplexMulTest_b_1_q, cstZeroWF_uid25_ac_uid6_fpComplexMulTest_q)
    BEGIN
        CASE (fracBz_uid443_rReal_uid16_fpComplexMulTest_s) IS
            WHEN "0" => fracBz_uid443_rReal_uid16_fpComplexMulTest_q <= redist66_fracB_uid434_rReal_uid16_fpComplexMulTest_b_1_q;
            WHEN "1" => fracBz_uid443_rReal_uid16_fpComplexMulTest_q <= cstZeroWF_uid25_ac_uid6_fpComplexMulTest_q;
            WHEN OTHERS => fracBz_uid443_rReal_uid16_fpComplexMulTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- oFracB_uid446_rReal_uid16_fpComplexMulTest(BITJOIN,445)@9
    oFracB_uid446_rReal_uid16_fpComplexMulTest_q <= invExcBZ_uid445_rReal_uid16_fpComplexMulTest_q & fracBz_uid443_rReal_uid16_fpComplexMulTest_q;

    -- rightPaddedIn_uid452_rReal_uid16_fpComplexMulTest(BITJOIN,451)@9
    rightPaddedIn_uid452_rReal_uid16_fpComplexMulTest_q <= oFracB_uid446_rReal_uid16_fpComplexMulTest_q & padConst_uid451_rReal_uid16_fpComplexMulTest_q;

    -- rightShiftStage0Idx6Rng48_uid801_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest(BITSELECT,800)@9
    rightShiftStage0Idx6Rng48_uid801_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_b <= rightPaddedIn_uid452_rReal_uid16_fpComplexMulTest_q(48 downto 48);

    -- rightShiftStage0Idx6_uid803_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest(BITJOIN,802)@9
    rightShiftStage0Idx6_uid803_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q <= rightShiftStage0Idx6Pad48_uid802_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q & rightShiftStage0Idx6Rng48_uid801_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_b;

    -- rightShiftStage0Idx5Rng40_uid798_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest(BITSELECT,797)@9
    rightShiftStage0Idx5Rng40_uid798_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_b <= rightPaddedIn_uid452_rReal_uid16_fpComplexMulTest_q(48 downto 40);

    -- rightShiftStage0Idx5_uid800_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest(BITJOIN,799)@9
    rightShiftStage0Idx5_uid800_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q <= rightShiftStage0Idx5Pad40_uid799_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q & rightShiftStage0Idx5Rng40_uid798_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_b;

    -- rightShiftStage0Idx4Rng32_uid795_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest(BITSELECT,794)@9
    rightShiftStage0Idx4Rng32_uid795_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_b <= rightPaddedIn_uid452_rReal_uid16_fpComplexMulTest_q(48 downto 32);

    -- rightShiftStage0Idx4_uid797_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest(BITJOIN,796)@9
    rightShiftStage0Idx4_uid797_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q <= rightShiftStage0Idx4Pad32_uid796_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q & rightShiftStage0Idx4Rng32_uid795_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_b;

    -- rightShiftStage0_uid806_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_msplit_1(MUX,1032)@9
    rightShiftStage0_uid806_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_msplit_1_s <= rightShiftStage0_uid806_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_selLSBs_merged_bit_select_b;
    rightShiftStage0_uid806_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_msplit_1_combproc: PROCESS (rightShiftStage0_uid806_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_msplit_1_s, rightShiftStage0Idx4_uid797_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q, rightShiftStage0Idx5_uid800_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q, rightShiftStage0Idx6_uid803_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q, rightShiftStage0Idx7_uid804_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q)
    BEGIN
        CASE (rightShiftStage0_uid806_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_msplit_1_s) IS
            WHEN "00" => rightShiftStage0_uid806_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_msplit_1_q <= rightShiftStage0Idx4_uid797_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q;
            WHEN "01" => rightShiftStage0_uid806_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_msplit_1_q <= rightShiftStage0Idx5_uid800_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q;
            WHEN "10" => rightShiftStage0_uid806_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_msplit_1_q <= rightShiftStage0Idx6_uid803_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q;
            WHEN "11" => rightShiftStage0_uid806_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_msplit_1_q <= rightShiftStage0Idx7_uid804_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q;
            WHEN OTHERS => rightShiftStage0_uid806_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_msplit_1_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rightShiftStage0Idx3Rng24_uid792_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest(BITSELECT,791)@9
    rightShiftStage0Idx3Rng24_uid792_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_b <= rightPaddedIn_uid452_rReal_uid16_fpComplexMulTest_q(48 downto 24);

    -- rightShiftStage0Idx3_uid794_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest(BITJOIN,793)@9
    rightShiftStage0Idx3_uid794_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q <= rightShiftStage0Idx3Pad24_uid793_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q & rightShiftStage0Idx3Rng24_uid792_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_b;

    -- rightShiftStage0Idx2Rng16_uid789_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest(BITSELECT,788)@9
    rightShiftStage0Idx2Rng16_uid789_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_b <= rightPaddedIn_uid452_rReal_uid16_fpComplexMulTest_q(48 downto 16);

    -- rightShiftStage0Idx2_uid791_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest(BITJOIN,790)@9
    rightShiftStage0Idx2_uid791_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q <= zs_uid712_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q & rightShiftStage0Idx2Rng16_uid789_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_b;

    -- rightShiftStage0Idx1Rng8_uid786_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest(BITSELECT,785)@9
    rightShiftStage0Idx1Rng8_uid786_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_b <= rightPaddedIn_uid452_rReal_uid16_fpComplexMulTest_q(48 downto 8);

    -- rightShiftStage0Idx1_uid788_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest(BITJOIN,787)@9
    rightShiftStage0Idx1_uid788_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q <= cstAllZWE_uid26_ac_uid6_fpComplexMulTest_q & rightShiftStage0Idx1Rng8_uid786_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_b;

    -- rightShiftStage0_uid806_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_msplit_0(MUX,1031)@9
    rightShiftStage0_uid806_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_msplit_0_s <= rightShiftStage0_uid806_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_selLSBs_merged_bit_select_b;
    rightShiftStage0_uid806_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_msplit_0_combproc: PROCESS (rightShiftStage0_uid806_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_msplit_0_s, rightPaddedIn_uid452_rReal_uid16_fpComplexMulTest_q, rightShiftStage0Idx1_uid788_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q, rightShiftStage0Idx2_uid791_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q, rightShiftStage0Idx3_uid794_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q)
    BEGIN
        CASE (rightShiftStage0_uid806_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_msplit_0_s) IS
            WHEN "00" => rightShiftStage0_uid806_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_msplit_0_q <= rightPaddedIn_uid452_rReal_uid16_fpComplexMulTest_q;
            WHEN "01" => rightShiftStage0_uid806_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_msplit_0_q <= rightShiftStage0Idx1_uid788_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q;
            WHEN "10" => rightShiftStage0_uid806_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_msplit_0_q <= rightShiftStage0Idx2_uid791_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q;
            WHEN "11" => rightShiftStage0_uid806_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_msplit_0_q <= rightShiftStage0Idx3_uid794_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q;
            WHEN OTHERS => rightShiftStage0_uid806_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_msplit_0_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rightShiftStageSel5Dto3_uid805_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_merged_bit_select(BITSELECT,1063)@9
    rightShiftStageSel5Dto3_uid805_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_merged_bit_select_in <= expAmExpB_uid447_rReal_uid16_fpComplexMulTest_q(5 downto 0);
    rightShiftStageSel5Dto3_uid805_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_merged_bit_select_b <= rightShiftStageSel5Dto3_uid805_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_merged_bit_select_in(5 downto 3);
    rightShiftStageSel5Dto3_uid805_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_merged_bit_select_c <= rightShiftStageSel5Dto3_uid805_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_merged_bit_select_in(2 downto 0);

    -- rightShiftStage0_uid806_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_selLSBs_merged_bit_select(BITSELECT,1075)@9
    rightShiftStage0_uid806_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_selLSBs_merged_bit_select_b <= rightShiftStageSel5Dto3_uid805_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_merged_bit_select_b(1 downto 0);
    rightShiftStage0_uid806_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_selLSBs_merged_bit_select_c <= rightShiftStageSel5Dto3_uid805_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_merged_bit_select_b(2 downto 2);

    -- rightShiftStage0_uid806_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_mfinal(MUX,1033)@9 + 1
    rightShiftStage0_uid806_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_mfinal_s <= rightShiftStage0_uid806_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_selLSBs_merged_bit_select_c;
    rightShiftStage0_uid806_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_mfinal_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            rightShiftStage0_uid806_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_mfinal_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            CASE (rightShiftStage0_uid806_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_mfinal_s) IS
                WHEN "0" => rightShiftStage0_uid806_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_mfinal_q <= rightShiftStage0_uid806_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_msplit_0_q;
                WHEN "1" => rightShiftStage0_uid806_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_mfinal_q <= rightShiftStage0_uid806_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_msplit_1_q;
                WHEN OTHERS => rightShiftStage0_uid806_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_mfinal_q <= (others => '0');
            END CASE;
        END IF;
    END PROCESS;

    -- rightShiftStage1Idx7Rng7_uid825_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest(BITSELECT,824)@10
    rightShiftStage1Idx7Rng7_uid825_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_b <= rightShiftStage0_uid806_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_mfinal_q(48 downto 7);

    -- rightShiftStage1Idx7_uid827_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest(BITJOIN,826)@10
    rightShiftStage1Idx7_uid827_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q <= rightShiftStage1Idx7Pad7_uid826_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q & rightShiftStage1Idx7Rng7_uid825_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_b;

    -- rightShiftStage1Idx6Rng6_uid822_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest(BITSELECT,821)@10
    rightShiftStage1Idx6Rng6_uid822_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_b <= rightShiftStage0_uid806_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_mfinal_q(48 downto 6);

    -- rightShiftStage1Idx6_uid824_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest(BITJOIN,823)@10
    rightShiftStage1Idx6_uid824_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q <= rightShiftStage1Idx6Pad6_uid823_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q & rightShiftStage1Idx6Rng6_uid822_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_b;

    -- rightShiftStage1Idx5Rng5_uid819_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest(BITSELECT,818)@10
    rightShiftStage1Idx5Rng5_uid819_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_b <= rightShiftStage0_uid806_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_mfinal_q(48 downto 5);

    -- rightShiftStage1Idx5_uid821_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest(BITJOIN,820)@10
    rightShiftStage1Idx5_uid821_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q <= rightShiftStage1Idx5Pad5_uid820_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q & rightShiftStage1Idx5Rng5_uid819_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_b;

    -- rightShiftStage1Idx4Rng4_uid816_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest(BITSELECT,815)@10
    rightShiftStage1Idx4Rng4_uid816_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_b <= rightShiftStage0_uid806_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_mfinal_q(48 downto 4);

    -- rightShiftStage1Idx4_uid818_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest(BITJOIN,817)@10
    rightShiftStage1Idx4_uid818_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q <= zs_uid726_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q & rightShiftStage1Idx4Rng4_uid816_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_b;

    -- rightShiftStage1_uid829_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_msplit_1(MUX,1037)@10
    rightShiftStage1_uid829_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_msplit_1_s <= rightShiftStage1_uid829_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_selLSBs_merged_bit_select_b;
    rightShiftStage1_uid829_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_msplit_1_combproc: PROCESS (rightShiftStage1_uid829_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_msplit_1_s, rightShiftStage1Idx4_uid818_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q, rightShiftStage1Idx5_uid821_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q, rightShiftStage1Idx6_uid824_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q, rightShiftStage1Idx7_uid827_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q)
    BEGIN
        CASE (rightShiftStage1_uid829_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_msplit_1_s) IS
            WHEN "00" => rightShiftStage1_uid829_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_msplit_1_q <= rightShiftStage1Idx4_uid818_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q;
            WHEN "01" => rightShiftStage1_uid829_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_msplit_1_q <= rightShiftStage1Idx5_uid821_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q;
            WHEN "10" => rightShiftStage1_uid829_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_msplit_1_q <= rightShiftStage1Idx6_uid824_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q;
            WHEN "11" => rightShiftStage1_uid829_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_msplit_1_q <= rightShiftStage1Idx7_uid827_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q;
            WHEN OTHERS => rightShiftStage1_uid829_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_msplit_1_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rightShiftStage1Idx3Rng3_uid813_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest(BITSELECT,812)@10
    rightShiftStage1Idx3Rng3_uid813_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_b <= rightShiftStage0_uid806_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_mfinal_q(48 downto 3);

    -- rightShiftStage1Idx3_uid815_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest(BITJOIN,814)@10
    rightShiftStage1Idx3_uid815_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q <= rightShiftStage1Idx3Pad3_uid814_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q & rightShiftStage1Idx3Rng3_uid813_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_b;

    -- rightShiftStage1Idx2Rng2_uid810_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest(BITSELECT,809)@10
    rightShiftStage1Idx2Rng2_uid810_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_b <= rightShiftStage0_uid806_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_mfinal_q(48 downto 2);

    -- rightShiftStage1Idx2_uid812_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest(BITJOIN,811)@10
    rightShiftStage1Idx2_uid812_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q <= zero2b_uid386_rReal_uid16_fpComplexMulTest_q & rightShiftStage1Idx2Rng2_uid810_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_b;

    -- rightShiftStage1Idx1Rng1_uid807_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest(BITSELECT,806)@10
    rightShiftStage1Idx1Rng1_uid807_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_b <= rightShiftStage0_uid806_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_mfinal_q(48 downto 1);

    -- rightShiftStage1Idx1_uid809_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest(BITJOIN,808)@10
    rightShiftStage1Idx1_uid809_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q <= GND_q & rightShiftStage1Idx1Rng1_uid807_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_b;

    -- rightShiftStage1_uid829_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_msplit_0(MUX,1036)@10
    rightShiftStage1_uid829_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_msplit_0_s <= rightShiftStage1_uid829_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_selLSBs_merged_bit_select_b;
    rightShiftStage1_uid829_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_msplit_0_combproc: PROCESS (rightShiftStage1_uid829_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_msplit_0_s, rightShiftStage0_uid806_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_mfinal_q, rightShiftStage1Idx1_uid809_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q, rightShiftStage1Idx2_uid812_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q, rightShiftStage1Idx3_uid815_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q)
    BEGIN
        CASE (rightShiftStage1_uid829_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_msplit_0_s) IS
            WHEN "00" => rightShiftStage1_uid829_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_msplit_0_q <= rightShiftStage0_uid806_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_mfinal_q;
            WHEN "01" => rightShiftStage1_uid829_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_msplit_0_q <= rightShiftStage1Idx1_uid809_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q;
            WHEN "10" => rightShiftStage1_uid829_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_msplit_0_q <= rightShiftStage1Idx2_uid812_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q;
            WHEN "11" => rightShiftStage1_uid829_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_msplit_0_q <= rightShiftStage1Idx3_uid815_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q;
            WHEN OTHERS => rightShiftStage1_uid829_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_msplit_0_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist9_rightShiftStageSel5Dto3_uid805_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_merged_bit_select_c_1(DELAY,1090)
    redist9_rightShiftStageSel5Dto3_uid805_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_merged_bit_select_c_1 : dspba_delay
    GENERIC MAP ( width => 3, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => rightShiftStageSel5Dto3_uid805_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_merged_bit_select_c, xout => redist9_rightShiftStageSel5Dto3_uid805_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_merged_bit_select_c_1_q, clk => clk, aclr => areset );

    -- rightShiftStage1_uid829_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_selLSBs_merged_bit_select(BITSELECT,1076)@10
    rightShiftStage1_uid829_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_selLSBs_merged_bit_select_b <= redist9_rightShiftStageSel5Dto3_uid805_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_merged_bit_select_c_1_q(1 downto 0);
    rightShiftStage1_uid829_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_selLSBs_merged_bit_select_c <= redist9_rightShiftStageSel5Dto3_uid805_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_merged_bit_select_c_1_q(2 downto 2);

    -- rightShiftStage1_uid829_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_mfinal(MUX,1038)@10
    rightShiftStage1_uid829_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_mfinal_s <= rightShiftStage1_uid829_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_selLSBs_merged_bit_select_c;
    rightShiftStage1_uid829_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_mfinal_combproc: PROCESS (rightShiftStage1_uid829_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_mfinal_s, rightShiftStage1_uid829_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_msplit_0_q, rightShiftStage1_uid829_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_msplit_1_q)
    BEGIN
        CASE (rightShiftStage1_uid829_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_mfinal_s) IS
            WHEN "0" => rightShiftStage1_uid829_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_mfinal_q <= rightShiftStage1_uid829_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_msplit_0_q;
            WHEN "1" => rightShiftStage1_uid829_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_mfinal_q <= rightShiftStage1_uid829_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_msplit_1_q;
            WHEN OTHERS => rightShiftStage1_uid829_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_mfinal_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- shiftedOut_uid785_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest(COMPARE,784)@9 + 1
    shiftedOut_uid785_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_a <= STD_LOGIC_VECTOR("00" & expAmExpB_uid447_rReal_uid16_fpComplexMulTest_q);
    shiftedOut_uid785_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_b <= STD_LOGIC_VECTOR("00000" & wIntCst_uid784_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q);
    shiftedOut_uid785_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            shiftedOut_uid785_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            shiftedOut_uid785_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_o <= STD_LOGIC_VECTOR(UNSIGNED(shiftedOut_uid785_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_a) - UNSIGNED(shiftedOut_uid785_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_b));
        END IF;
    END PROCESS;
    shiftedOut_uid785_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_n(0) <= not (shiftedOut_uid785_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_o(10));

    -- r_uid831_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest(MUX,830)@10
    r_uid831_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_s <= shiftedOut_uid785_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_n;
    r_uid831_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_combproc: PROCESS (r_uid831_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_s, rightShiftStage1_uid829_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_mfinal_q, rightShiftStage0Idx7_uid804_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q)
    BEGIN
        CASE (r_uid831_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_s) IS
            WHEN "0" => r_uid831_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q <= rightShiftStage1_uid829_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_mfinal_q;
            WHEN "1" => r_uid831_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q <= rightShiftStage0Idx7_uid804_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q;
            WHEN OTHERS => r_uid831_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- alignFracBPostShiftOut_uid455_rReal_uid16_fpComplexMulTest(LOGICAL,454)@10 + 1
    alignFracBPostShiftOut_uid455_rReal_uid16_fpComplexMulTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((48 downto 1 => iShiftedOut_uid454_rReal_uid16_fpComplexMulTest_q(0)) & iShiftedOut_uid454_rReal_uid16_fpComplexMulTest_q));
    alignFracBPostShiftOut_uid455_rReal_uid16_fpComplexMulTest_qi <= r_uid831_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q and alignFracBPostShiftOut_uid455_rReal_uid16_fpComplexMulTest_b;
    alignFracBPostShiftOut_uid455_rReal_uid16_fpComplexMulTest_delay : dspba_delay
    GENERIC MAP ( width => 49, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => alignFracBPostShiftOut_uid455_rReal_uid16_fpComplexMulTest_qi, xout => alignFracBPostShiftOut_uid455_rReal_uid16_fpComplexMulTest_q, clk => clk, aclr => areset );

    -- stickyBits_uid456_rReal_uid16_fpComplexMulTest_merged_bit_select(BITSELECT,1064)@11
    stickyBits_uid456_rReal_uid16_fpComplexMulTest_merged_bit_select_b <= alignFracBPostShiftOut_uid455_rReal_uid16_fpComplexMulTest_q(22 downto 0);
    stickyBits_uid456_rReal_uid16_fpComplexMulTest_merged_bit_select_c <= alignFracBPostShiftOut_uid455_rReal_uid16_fpComplexMulTest_q(48 downto 23);

    -- fracBAddOp_uid467_rReal_uid16_fpComplexMulTest(BITJOIN,466)@11
    fracBAddOp_uid467_rReal_uid16_fpComplexMulTest_q <= GND_q & stickyBits_uid456_rReal_uid16_fpComplexMulTest_merged_bit_select_c;

    -- fracBAddOpPostXor_uid468_rReal_uid16_fpComplexMulTest(LOGICAL,467)@11 + 1
    fracBAddOpPostXor_uid468_rReal_uid16_fpComplexMulTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 1 => effSub_uid437_rReal_uid16_fpComplexMulTest_q(0)) & effSub_uid437_rReal_uid16_fpComplexMulTest_q));
    fracBAddOpPostXor_uid468_rReal_uid16_fpComplexMulTest_qi <= fracBAddOp_uid467_rReal_uid16_fpComplexMulTest_q xor fracBAddOpPostXor_uid468_rReal_uid16_fpComplexMulTest_b;
    fracBAddOpPostXor_uid468_rReal_uid16_fpComplexMulTest_delay : dspba_delay
    GENERIC MAP ( width => 27, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => fracBAddOpPostXor_uid468_rReal_uid16_fpComplexMulTest_qi, xout => fracBAddOpPostXor_uid468_rReal_uid16_fpComplexMulTest_q, clk => clk, aclr => areset );

    -- fracA_uid433_rReal_uid16_fpComplexMulTest(BITSELECT,432)@8
    fracA_uid433_rReal_uid16_fpComplexMulTest_in <= aSig_uid421_rReal_uid16_fpComplexMulTest_q(22 downto 0);
    fracA_uid433_rReal_uid16_fpComplexMulTest_b <= fracA_uid433_rReal_uid16_fpComplexMulTest_in(22 downto 0);

    -- redist67_fracA_uid433_rReal_uid16_fpComplexMulTest_b_4(DELAY,1148)
    redist67_fracA_uid433_rReal_uid16_fpComplexMulTest_b_4 : dspba_delay
    GENERIC MAP ( width => 23, depth => 4, reset_kind => "ASYNC" )
    PORT MAP ( xin => fracA_uid433_rReal_uid16_fpComplexMulTest_b, xout => redist67_fracA_uid433_rReal_uid16_fpComplexMulTest_b_4_q, clk => clk, aclr => areset );

    -- cmpEQ_stickyBits_cZwF_uid458_rReal_uid16_fpComplexMulTest(LOGICAL,457)@11
    cmpEQ_stickyBits_cZwF_uid458_rReal_uid16_fpComplexMulTest_q <= "1" WHEN stickyBits_uid456_rReal_uid16_fpComplexMulTest_merged_bit_select_b = cstZeroWF_uid25_ac_uid6_fpComplexMulTest_q ELSE "0";

    -- effSubInvSticky_uid461_rReal_uid16_fpComplexMulTest(LOGICAL,460)@11 + 1
    effSubInvSticky_uid461_rReal_uid16_fpComplexMulTest_qi <= effSub_uid437_rReal_uid16_fpComplexMulTest_q and cmpEQ_stickyBits_cZwF_uid458_rReal_uid16_fpComplexMulTest_q;
    effSubInvSticky_uid461_rReal_uid16_fpComplexMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => effSubInvSticky_uid461_rReal_uid16_fpComplexMulTest_qi, xout => effSubInvSticky_uid461_rReal_uid16_fpComplexMulTest_q, clk => clk, aclr => areset );

    -- fracAAddOp_uid464_rReal_uid16_fpComplexMulTest(BITJOIN,463)@12
    fracAAddOp_uid464_rReal_uid16_fpComplexMulTest_q <= one2b_uid387_rReal_uid16_fpComplexMulTest_q & redist67_fracA_uid433_rReal_uid16_fpComplexMulTest_b_4_q & GND_q & effSubInvSticky_uid461_rReal_uid16_fpComplexMulTest_q;

    -- fracAddResult_uid469_rReal_uid16_fpComplexMulTest(ADD,468)@12
    fracAddResult_uid469_rReal_uid16_fpComplexMulTest_a <= STD_LOGIC_VECTOR("0" & fracAAddOp_uid464_rReal_uid16_fpComplexMulTest_q);
    fracAddResult_uid469_rReal_uid16_fpComplexMulTest_b <= STD_LOGIC_VECTOR("0" & fracBAddOpPostXor_uid468_rReal_uid16_fpComplexMulTest_q);
    fracAddResult_uid469_rReal_uid16_fpComplexMulTest_o <= STD_LOGIC_VECTOR(UNSIGNED(fracAddResult_uid469_rReal_uid16_fpComplexMulTest_a) + UNSIGNED(fracAddResult_uid469_rReal_uid16_fpComplexMulTest_b));
    fracAddResult_uid469_rReal_uid16_fpComplexMulTest_q <= fracAddResult_uid469_rReal_uid16_fpComplexMulTest_o(27 downto 0);

    -- rangeFracAddResultMwfp3Dto0_uid470_rReal_uid16_fpComplexMulTest(BITSELECT,469)@12
    rangeFracAddResultMwfp3Dto0_uid470_rReal_uid16_fpComplexMulTest_in <= fracAddResult_uid469_rReal_uid16_fpComplexMulTest_q(26 downto 0);
    rangeFracAddResultMwfp3Dto0_uid470_rReal_uid16_fpComplexMulTest_b <= rangeFracAddResultMwfp3Dto0_uid470_rReal_uid16_fpComplexMulTest_in(26 downto 0);

    -- redist60_cmpEQ_stickyBits_cZwF_uid458_rReal_uid16_fpComplexMulTest_q_1(DELAY,1141)
    redist60_cmpEQ_stickyBits_cZwF_uid458_rReal_uid16_fpComplexMulTest_q_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => cmpEQ_stickyBits_cZwF_uid458_rReal_uid16_fpComplexMulTest_q, xout => redist60_cmpEQ_stickyBits_cZwF_uid458_rReal_uid16_fpComplexMulTest_q_1_q, clk => clk, aclr => areset );

    -- invCmpEQ_stickyBits_cZwF_uid459_rReal_uid16_fpComplexMulTest(LOGICAL,458)@12
    invCmpEQ_stickyBits_cZwF_uid459_rReal_uid16_fpComplexMulTest_q <= not (redist60_cmpEQ_stickyBits_cZwF_uid458_rReal_uid16_fpComplexMulTest_q_1_q);

    -- fracGRS_uid471_rReal_uid16_fpComplexMulTest(BITJOIN,470)@12
    fracGRS_uid471_rReal_uid16_fpComplexMulTest_q <= rangeFracAddResultMwfp3Dto0_uid470_rReal_uid16_fpComplexMulTest_b & invCmpEQ_stickyBits_cZwF_uid459_rReal_uid16_fpComplexMulTest_q;

    -- rVStage_uid713_lzCountVal_uid472_rReal_uid16_fpComplexMulTest(BITSELECT,712)@12
    rVStage_uid713_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_b <= fracGRS_uid471_rReal_uid16_fpComplexMulTest_q(27 downto 12);

    -- vCount_uid714_lzCountVal_uid472_rReal_uid16_fpComplexMulTest(LOGICAL,713)@12 + 1
    vCount_uid714_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_qi <= "1" WHEN rVStage_uid713_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_b = zs_uid712_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q ELSE "0";
    vCount_uid714_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => vCount_uid714_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_qi, xout => vCount_uid714_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q, clk => clk, aclr => areset );

    -- redist20_vCount_uid714_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q_2(DELAY,1101)
    redist20_vCount_uid714_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => vCount_uid714_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q, xout => redist20_vCount_uid714_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q_2_q, clk => clk, aclr => areset );

    -- redist58_fracGRS_uid471_rReal_uid16_fpComplexMulTest_q_1(DELAY,1139)
    redist58_fracGRS_uid471_rReal_uid16_fpComplexMulTest_q_1 : dspba_delay
    GENERIC MAP ( width => 28, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => fracGRS_uid471_rReal_uid16_fpComplexMulTest_q, xout => redist58_fracGRS_uid471_rReal_uid16_fpComplexMulTest_q_1_q, clk => clk, aclr => areset );

    -- vStage_uid716_lzCountVal_uid472_rReal_uid16_fpComplexMulTest(BITSELECT,715)@13
    vStage_uid716_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_in <= redist58_fracGRS_uid471_rReal_uid16_fpComplexMulTest_q_1_q(11 downto 0);
    vStage_uid716_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_b <= vStage_uid716_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_in(11 downto 0);

    -- cStage_uid717_lzCountVal_uid472_rReal_uid16_fpComplexMulTest(BITJOIN,716)@13
    cStage_uid717_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q <= vStage_uid716_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_b & mO_uid715_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q;

    -- redist21_rVStage_uid713_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_b_1(DELAY,1102)
    redist21_rVStage_uid713_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_b_1 : dspba_delay
    GENERIC MAP ( width => 16, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => rVStage_uid713_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_b, xout => redist21_rVStage_uid713_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_b_1_q, clk => clk, aclr => areset );

    -- vStagei_uid719_lzCountVal_uid472_rReal_uid16_fpComplexMulTest(MUX,718)@13
    vStagei_uid719_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_s <= vCount_uid714_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q;
    vStagei_uid719_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_combproc: PROCESS (vStagei_uid719_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_s, redist21_rVStage_uid713_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_b_1_q, cStage_uid717_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q)
    BEGIN
        CASE (vStagei_uid719_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_s) IS
            WHEN "0" => vStagei_uid719_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q <= redist21_rVStage_uid713_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_b_1_q;
            WHEN "1" => vStagei_uid719_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q <= cStage_uid717_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q;
            WHEN OTHERS => vStagei_uid719_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid721_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_merged_bit_select(BITSELECT,1067)@13
    rVStage_uid721_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_merged_bit_select_b <= vStagei_uid719_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q(15 downto 8);
    rVStage_uid721_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_merged_bit_select_c <= vStagei_uid719_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q(7 downto 0);

    -- vCount_uid722_lzCountVal_uid472_rReal_uid16_fpComplexMulTest(LOGICAL,721)@13
    vCount_uid722_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q <= "1" WHEN rVStage_uid721_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_merged_bit_select_b = cstAllZWE_uid26_ac_uid6_fpComplexMulTest_q ELSE "0";

    -- redist18_vCount_uid722_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q_1(DELAY,1099)
    redist18_vCount_uid722_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => vCount_uid722_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q, xout => redist18_vCount_uid722_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q_1_q, clk => clk, aclr => areset );

    -- vStagei_uid725_lzCountVal_uid472_rReal_uid16_fpComplexMulTest(MUX,724)@13
    vStagei_uid725_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_s <= vCount_uid722_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q;
    vStagei_uid725_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_combproc: PROCESS (vStagei_uid725_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_s, rVStage_uid721_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_merged_bit_select_b, rVStage_uid721_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_merged_bit_select_c)
    BEGIN
        CASE (vStagei_uid725_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_s) IS
            WHEN "0" => vStagei_uid725_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q <= rVStage_uid721_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_merged_bit_select_b;
            WHEN "1" => vStagei_uid725_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q <= rVStage_uid721_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_merged_bit_select_c;
            WHEN OTHERS => vStagei_uid725_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid727_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_merged_bit_select(BITSELECT,1068)@13
    rVStage_uid727_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_merged_bit_select_b <= vStagei_uid725_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q(7 downto 4);
    rVStage_uid727_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_merged_bit_select_c <= vStagei_uid725_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q(3 downto 0);

    -- vCount_uid728_lzCountVal_uid472_rReal_uid16_fpComplexMulTest(LOGICAL,727)@13 + 1
    vCount_uid728_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_qi <= "1" WHEN rVStage_uid727_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_merged_bit_select_b = zs_uid726_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q ELSE "0";
    vCount_uid728_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => vCount_uid728_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_qi, xout => vCount_uid728_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q, clk => clk, aclr => areset );

    -- redist7_rVStage_uid727_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_merged_bit_select_c_1(DELAY,1088)
    redist7_rVStage_uid727_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_merged_bit_select_c_1 : dspba_delay
    GENERIC MAP ( width => 4, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => rVStage_uid727_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_merged_bit_select_c, xout => redist7_rVStage_uid727_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_merged_bit_select_c_1_q, clk => clk, aclr => areset );

    -- redist6_rVStage_uid727_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_merged_bit_select_b_1(DELAY,1087)
    redist6_rVStage_uid727_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_merged_bit_select_b_1 : dspba_delay
    GENERIC MAP ( width => 4, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => rVStage_uid727_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_merged_bit_select_b, xout => redist6_rVStage_uid727_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_merged_bit_select_b_1_q, clk => clk, aclr => areset );

    -- vStagei_uid731_lzCountVal_uid472_rReal_uid16_fpComplexMulTest(MUX,730)@14
    vStagei_uid731_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_s <= vCount_uid728_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q;
    vStagei_uid731_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_combproc: PROCESS (vStagei_uid731_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_s, redist6_rVStage_uid727_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_merged_bit_select_b_1_q, redist7_rVStage_uid727_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_merged_bit_select_c_1_q)
    BEGIN
        CASE (vStagei_uid731_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_s) IS
            WHEN "0" => vStagei_uid731_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q <= redist6_rVStage_uid727_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_merged_bit_select_b_1_q;
            WHEN "1" => vStagei_uid731_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q <= redist7_rVStage_uid727_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_merged_bit_select_c_1_q;
            WHEN OTHERS => vStagei_uid731_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid733_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_merged_bit_select(BITSELECT,1069)@14
    rVStage_uid733_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_merged_bit_select_b <= vStagei_uid731_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q(3 downto 2);
    rVStage_uid733_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_merged_bit_select_c <= vStagei_uid731_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q(1 downto 0);

    -- vCount_uid734_lzCountVal_uid472_rReal_uid16_fpComplexMulTest(LOGICAL,733)@14
    vCount_uid734_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q <= "1" WHEN rVStage_uid733_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_merged_bit_select_b = zero2b_uid386_rReal_uid16_fpComplexMulTest_q ELSE "0";

    -- vStagei_uid737_lzCountVal_uid472_rReal_uid16_fpComplexMulTest(MUX,736)@14
    vStagei_uid737_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_s <= vCount_uid734_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q;
    vStagei_uid737_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_combproc: PROCESS (vStagei_uid737_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_s, rVStage_uid733_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_merged_bit_select_b, rVStage_uid733_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_merged_bit_select_c)
    BEGIN
        CASE (vStagei_uid737_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_s) IS
            WHEN "0" => vStagei_uid737_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q <= rVStage_uid733_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_merged_bit_select_b;
            WHEN "1" => vStagei_uid737_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q <= rVStage_uid733_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_merged_bit_select_c;
            WHEN OTHERS => vStagei_uid737_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid739_lzCountVal_uid472_rReal_uid16_fpComplexMulTest(BITSELECT,738)@14
    rVStage_uid739_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_b <= vStagei_uid737_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q(1 downto 1);

    -- vCount_uid740_lzCountVal_uid472_rReal_uid16_fpComplexMulTest(LOGICAL,739)@14
    vCount_uid740_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q <= "1" WHEN rVStage_uid739_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_b = GND_q ELSE "0";

    -- r_uid741_lzCountVal_uid472_rReal_uid16_fpComplexMulTest(BITJOIN,740)@14
    r_uid741_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q <= redist20_vCount_uid714_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q_2_q & redist18_vCount_uid722_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q_1_q & vCount_uid728_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q & vCount_uid734_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q & vCount_uid740_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q;

    -- aMinusA_uid474_rReal_uid16_fpComplexMulTest(LOGICAL,473)@14 + 1
    aMinusA_uid474_rReal_uid16_fpComplexMulTest_qi <= "1" WHEN r_uid741_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q = cAmA_uid473_rReal_uid16_fpComplexMulTest_q ELSE "0";
    aMinusA_uid474_rReal_uid16_fpComplexMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => aMinusA_uid474_rReal_uid16_fpComplexMulTest_qi, xout => aMinusA_uid474_rReal_uid16_fpComplexMulTest_q, clk => clk, aclr => areset );

    -- redist57_aMinusA_uid474_rReal_uid16_fpComplexMulTest_q_3(DELAY,1138)
    redist57_aMinusA_uid474_rReal_uid16_fpComplexMulTest_q_3 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => aMinusA_uid474_rReal_uid16_fpComplexMulTest_q, xout => redist57_aMinusA_uid474_rReal_uid16_fpComplexMulTest_q_3_q, clk => clk, aclr => areset );

    -- invAMinusA_uid519_rReal_uid16_fpComplexMulTest(LOGICAL,518)@17
    invAMinusA_uid519_rReal_uid16_fpComplexMulTest_q <= not (redist57_aMinusA_uid474_rReal_uid16_fpComplexMulTest_q_3_q);

    -- redist65_sigA_uid435_rReal_uid16_fpComplexMulTest_b_9(DELAY,1146)
    redist65_sigA_uid435_rReal_uid16_fpComplexMulTest_b_9 : dspba_delay
    GENERIC MAP ( width => 1, depth => 6, reset_kind => "ASYNC" )
    PORT MAP ( xin => redist64_sigA_uid435_rReal_uid16_fpComplexMulTest_b_3_q, xout => redist65_sigA_uid435_rReal_uid16_fpComplexMulTest_b_9_q, clk => clk, aclr => areset );

    -- redist78_excX_uid399_rReal_uid16_fpComplexMulTest_b_10(DELAY,1159)
    redist78_excX_uid399_rReal_uid16_fpComplexMulTest_b_10 : dspba_delay
    GENERIC MAP ( width => 2, depth => 10, reset_kind => "ASYNC" )
    PORT MAP ( xin => excX_uid399_rReal_uid16_fpComplexMulTest_b, xout => redist78_excX_uid399_rReal_uid16_fpComplexMulTest_b_10_q, clk => clk, aclr => areset );

    -- excXReg_uid405_rReal_uid16_fpComplexMulTest(LOGICAL,404)@17
    excXReg_uid405_rReal_uid16_fpComplexMulTest_q <= "1" WHEN redist78_excX_uid399_rReal_uid16_fpComplexMulTest_b_10_q = one2b_uid387_rReal_uid16_fpComplexMulTest_q ELSE "0";

    -- redist79_excX_uid385_rReal_uid16_fpComplexMulTest_b_9(DELAY,1160)
    redist79_excX_uid385_rReal_uid16_fpComplexMulTest_b_9 : dspba_delay
    GENERIC MAP ( width => 2, depth => 9, reset_kind => "ASYNC" )
    PORT MAP ( xin => excX_uid385_rReal_uid16_fpComplexMulTest_b, xout => redist79_excX_uid385_rReal_uid16_fpComplexMulTest_b_9_q, clk => clk, aclr => areset );

    -- excXReg_uid391_rReal_uid16_fpComplexMulTest(LOGICAL,390)@17
    excXReg_uid391_rReal_uid16_fpComplexMulTest_q <= "1" WHEN redist79_excX_uid385_rReal_uid16_fpComplexMulTest_b_9_q = one2b_uid387_rReal_uid16_fpComplexMulTest_q ELSE "0";

    -- redist77_xGTEy_uid413_rReal_uid16_fpComplexMulTest_q_9(DELAY,1158)
    redist77_xGTEy_uid413_rReal_uid16_fpComplexMulTest_q_9 : dspba_delay
    GENERIC MAP ( width => 1, depth => 9, reset_kind => "ASYNC" )
    PORT MAP ( xin => xGTEy_uid413_rReal_uid16_fpComplexMulTest_q, xout => redist77_xGTEy_uid413_rReal_uid16_fpComplexMulTest_q_9_q, clk => clk, aclr => areset );

    -- excBR_uid429_rReal_uid16_fpComplexMulTest(MUX,428)@17
    excBR_uid429_rReal_uid16_fpComplexMulTest_s <= redist77_xGTEy_uid413_rReal_uid16_fpComplexMulTest_q_9_q;
    excBR_uid429_rReal_uid16_fpComplexMulTest_combproc: PROCESS (excBR_uid429_rReal_uid16_fpComplexMulTest_s, excXReg_uid391_rReal_uid16_fpComplexMulTest_q, excXReg_uid405_rReal_uid16_fpComplexMulTest_q)
    BEGIN
        CASE (excBR_uid429_rReal_uid16_fpComplexMulTest_s) IS
            WHEN "0" => excBR_uid429_rReal_uid16_fpComplexMulTest_q <= excXReg_uid391_rReal_uid16_fpComplexMulTest_q;
            WHEN "1" => excBR_uid429_rReal_uid16_fpComplexMulTest_q <= excXReg_uid405_rReal_uid16_fpComplexMulTest_q;
            WHEN OTHERS => excBR_uid429_rReal_uid16_fpComplexMulTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- excAR_uid425_rReal_uid16_fpComplexMulTest(MUX,424)@17
    excAR_uid425_rReal_uid16_fpComplexMulTest_s <= redist77_xGTEy_uid413_rReal_uid16_fpComplexMulTest_q_9_q;
    excAR_uid425_rReal_uid16_fpComplexMulTest_combproc: PROCESS (excAR_uid425_rReal_uid16_fpComplexMulTest_s, excXReg_uid405_rReal_uid16_fpComplexMulTest_q, excXReg_uid391_rReal_uid16_fpComplexMulTest_q)
    BEGIN
        CASE (excAR_uid425_rReal_uid16_fpComplexMulTest_s) IS
            WHEN "0" => excAR_uid425_rReal_uid16_fpComplexMulTest_q <= excXReg_uid405_rReal_uid16_fpComplexMulTest_q;
            WHEN "1" => excAR_uid425_rReal_uid16_fpComplexMulTest_q <= excXReg_uid391_rReal_uid16_fpComplexMulTest_q;
            WHEN OTHERS => excAR_uid425_rReal_uid16_fpComplexMulTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- signRReg_uid520_rReal_uid16_fpComplexMulTest(LOGICAL,519)@17
    signRReg_uid520_rReal_uid16_fpComplexMulTest_q <= excAR_uid425_rReal_uid16_fpComplexMulTest_q and excBR_uid429_rReal_uid16_fpComplexMulTest_q and redist65_sigA_uid435_rReal_uid16_fpComplexMulTest_b_9_q and invAMinusA_uid519_rReal_uid16_fpComplexMulTest_q;

    -- redist63_sigB_uid436_rReal_uid16_fpComplexMulTest_b_9(DELAY,1144)
    redist63_sigB_uid436_rReal_uid16_fpComplexMulTest_b_9 : dspba_delay
    GENERIC MAP ( width => 1, depth => 6, reset_kind => "ASYNC" )
    PORT MAP ( xin => redist62_sigB_uid436_rReal_uid16_fpComplexMulTest_b_3_q, xout => redist63_sigB_uid436_rReal_uid16_fpComplexMulTest_b_9_q, clk => clk, aclr => areset );

    -- redist70_excBZ_uid430_rReal_uid16_fpComplexMulTest_q_9(DELAY,1151)
    redist70_excBZ_uid430_rReal_uid16_fpComplexMulTest_q_9 : dspba_delay
    GENERIC MAP ( width => 1, depth => 8, reset_kind => "ASYNC" )
    PORT MAP ( xin => redist69_excBZ_uid430_rReal_uid16_fpComplexMulTest_q_1_q, xout => redist70_excBZ_uid430_rReal_uid16_fpComplexMulTest_q_9_q, clk => clk, aclr => areset );

    -- excAZ_uid426_rReal_uid16_fpComplexMulTest(MUX,425)@8 + 1
    excAZ_uid426_rReal_uid16_fpComplexMulTest_s <= xGTEy_uid413_rReal_uid16_fpComplexMulTest_q;
    excAZ_uid426_rReal_uid16_fpComplexMulTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            excAZ_uid426_rReal_uid16_fpComplexMulTest_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            CASE (excAZ_uid426_rReal_uid16_fpComplexMulTest_s) IS
                WHEN "0" => excAZ_uid426_rReal_uid16_fpComplexMulTest_q <= excXZero_uid404_rReal_uid16_fpComplexMulTest_q;
                WHEN "1" => excAZ_uid426_rReal_uid16_fpComplexMulTest_q <= excXZero_uid390_rReal_uid16_fpComplexMulTest_q;
                WHEN OTHERS => excAZ_uid426_rReal_uid16_fpComplexMulTest_q <= (others => '0');
            END CASE;
        END IF;
    END PROCESS;

    -- redist72_excAZ_uid426_rReal_uid16_fpComplexMulTest_q_9(DELAY,1153)
    redist72_excAZ_uid426_rReal_uid16_fpComplexMulTest_q_9 : dspba_delay
    GENERIC MAP ( width => 1, depth => 8, reset_kind => "ASYNC" )
    PORT MAP ( xin => excAZ_uid426_rReal_uid16_fpComplexMulTest_q, xout => redist72_excAZ_uid426_rReal_uid16_fpComplexMulTest_q_9_q, clk => clk, aclr => areset );

    -- excAZBZSigASigB_uid524_rReal_uid16_fpComplexMulTest(LOGICAL,523)@17
    excAZBZSigASigB_uid524_rReal_uid16_fpComplexMulTest_q <= redist72_excAZ_uid426_rReal_uid16_fpComplexMulTest_q_9_q and redist70_excBZ_uid430_rReal_uid16_fpComplexMulTest_q_9_q and redist65_sigA_uid435_rReal_uid16_fpComplexMulTest_b_9_q and redist63_sigB_uid436_rReal_uid16_fpComplexMulTest_b_9_q;

    -- excBZARSigA_uid525_rReal_uid16_fpComplexMulTest(LOGICAL,524)@17
    excBZARSigA_uid525_rReal_uid16_fpComplexMulTest_q <= redist70_excBZ_uid430_rReal_uid16_fpComplexMulTest_q_9_q and excAR_uid425_rReal_uid16_fpComplexMulTest_q and redist65_sigA_uid435_rReal_uid16_fpComplexMulTest_b_9_q;

    -- signRZero_uid526_rReal_uid16_fpComplexMulTest(LOGICAL,525)@17
    signRZero_uid526_rReal_uid16_fpComplexMulTest_q <= excBZARSigA_uid525_rReal_uid16_fpComplexMulTest_q or excAZBZSigASigB_uid524_rReal_uid16_fpComplexMulTest_q;

    -- excXInf_uid406_rReal_uid16_fpComplexMulTest(LOGICAL,405)@17
    excXInf_uid406_rReal_uid16_fpComplexMulTest_q <= "1" WHEN redist78_excX_uid399_rReal_uid16_fpComplexMulTest_b_10_q = two2b_uid388_rReal_uid16_fpComplexMulTest_q ELSE "0";

    -- excXInf_uid392_rReal_uid16_fpComplexMulTest(LOGICAL,391)@17
    excXInf_uid392_rReal_uid16_fpComplexMulTest_q <= "1" WHEN redist79_excX_uid385_rReal_uid16_fpComplexMulTest_b_9_q = two2b_uid388_rReal_uid16_fpComplexMulTest_q ELSE "0";

    -- excBI_uid427_rReal_uid16_fpComplexMulTest(MUX,426)@17
    excBI_uid427_rReal_uid16_fpComplexMulTest_s <= redist77_xGTEy_uid413_rReal_uid16_fpComplexMulTest_q_9_q;
    excBI_uid427_rReal_uid16_fpComplexMulTest_combproc: PROCESS (excBI_uid427_rReal_uid16_fpComplexMulTest_s, excXInf_uid392_rReal_uid16_fpComplexMulTest_q, excXInf_uid406_rReal_uid16_fpComplexMulTest_q)
    BEGIN
        CASE (excBI_uid427_rReal_uid16_fpComplexMulTest_s) IS
            WHEN "0" => excBI_uid427_rReal_uid16_fpComplexMulTest_q <= excXInf_uid392_rReal_uid16_fpComplexMulTest_q;
            WHEN "1" => excBI_uid427_rReal_uid16_fpComplexMulTest_q <= excXInf_uid406_rReal_uid16_fpComplexMulTest_q;
            WHEN OTHERS => excBI_uid427_rReal_uid16_fpComplexMulTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- sigBBInf_uid521_rReal_uid16_fpComplexMulTest(LOGICAL,520)@17
    sigBBInf_uid521_rReal_uid16_fpComplexMulTest_q <= redist63_sigB_uid436_rReal_uid16_fpComplexMulTest_b_9_q and excBI_uid427_rReal_uid16_fpComplexMulTest_q;

    -- excAI_uid423_rReal_uid16_fpComplexMulTest(MUX,422)@17
    excAI_uid423_rReal_uid16_fpComplexMulTest_s <= redist77_xGTEy_uid413_rReal_uid16_fpComplexMulTest_q_9_q;
    excAI_uid423_rReal_uid16_fpComplexMulTest_combproc: PROCESS (excAI_uid423_rReal_uid16_fpComplexMulTest_s, excXInf_uid406_rReal_uid16_fpComplexMulTest_q, excXInf_uid392_rReal_uid16_fpComplexMulTest_q)
    BEGIN
        CASE (excAI_uid423_rReal_uid16_fpComplexMulTest_s) IS
            WHEN "0" => excAI_uid423_rReal_uid16_fpComplexMulTest_q <= excXInf_uid406_rReal_uid16_fpComplexMulTest_q;
            WHEN "1" => excAI_uid423_rReal_uid16_fpComplexMulTest_q <= excXInf_uid392_rReal_uid16_fpComplexMulTest_q;
            WHEN OTHERS => excAI_uid423_rReal_uid16_fpComplexMulTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- sigAAInf_uid522_rReal_uid16_fpComplexMulTest(LOGICAL,521)@17
    sigAAInf_uid522_rReal_uid16_fpComplexMulTest_q <= redist65_sigA_uid435_rReal_uid16_fpComplexMulTest_b_9_q and excAI_uid423_rReal_uid16_fpComplexMulTest_q;

    -- signRInf_uid523_rReal_uid16_fpComplexMulTest(LOGICAL,522)@17
    signRInf_uid523_rReal_uid16_fpComplexMulTest_q <= sigAAInf_uid522_rReal_uid16_fpComplexMulTest_q or sigBBInf_uid521_rReal_uid16_fpComplexMulTest_q;

    -- signRInfRZRReg_uid527_rReal_uid16_fpComplexMulTest(LOGICAL,526)@17 + 1
    signRInfRZRReg_uid527_rReal_uid16_fpComplexMulTest_qi <= signRInf_uid523_rReal_uid16_fpComplexMulTest_q or signRZero_uid526_rReal_uid16_fpComplexMulTest_q or signRReg_uid520_rReal_uid16_fpComplexMulTest_q;
    signRInfRZRReg_uid527_rReal_uid16_fpComplexMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => signRInfRZRReg_uid527_rReal_uid16_fpComplexMulTest_qi, xout => signRInfRZRReg_uid527_rReal_uid16_fpComplexMulTest_q, clk => clk, aclr => areset );

    -- excXNaN_uid407_rReal_uid16_fpComplexMulTest(LOGICAL,406)@17
    excXNaN_uid407_rReal_uid16_fpComplexMulTest_q <= "1" WHEN redist78_excX_uid399_rReal_uid16_fpComplexMulTest_b_10_q = three2b_uid389_rReal_uid16_fpComplexMulTest_q ELSE "0";

    -- excXNaN_uid393_rReal_uid16_fpComplexMulTest(LOGICAL,392)@17
    excXNaN_uid393_rReal_uid16_fpComplexMulTest_q <= "1" WHEN redist79_excX_uid385_rReal_uid16_fpComplexMulTest_b_9_q = three2b_uid389_rReal_uid16_fpComplexMulTest_q ELSE "0";

    -- excBN_uid428_rReal_uid16_fpComplexMulTest(MUX,427)@17 + 1
    excBN_uid428_rReal_uid16_fpComplexMulTest_s <= redist77_xGTEy_uid413_rReal_uid16_fpComplexMulTest_q_9_q;
    excBN_uid428_rReal_uid16_fpComplexMulTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            excBN_uid428_rReal_uid16_fpComplexMulTest_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            CASE (excBN_uid428_rReal_uid16_fpComplexMulTest_s) IS
                WHEN "0" => excBN_uid428_rReal_uid16_fpComplexMulTest_q <= excXNaN_uid393_rReal_uid16_fpComplexMulTest_q;
                WHEN "1" => excBN_uid428_rReal_uid16_fpComplexMulTest_q <= excXNaN_uid407_rReal_uid16_fpComplexMulTest_q;
                WHEN OTHERS => excBN_uid428_rReal_uid16_fpComplexMulTest_q <= (others => '0');
            END CASE;
        END IF;
    END PROCESS;

    -- excAN_uid424_rReal_uid16_fpComplexMulTest(MUX,423)@17 + 1
    excAN_uid424_rReal_uid16_fpComplexMulTest_s <= redist77_xGTEy_uid413_rReal_uid16_fpComplexMulTest_q_9_q;
    excAN_uid424_rReal_uid16_fpComplexMulTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            excAN_uid424_rReal_uid16_fpComplexMulTest_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            CASE (excAN_uid424_rReal_uid16_fpComplexMulTest_s) IS
                WHEN "0" => excAN_uid424_rReal_uid16_fpComplexMulTest_q <= excXNaN_uid407_rReal_uid16_fpComplexMulTest_q;
                WHEN "1" => excAN_uid424_rReal_uid16_fpComplexMulTest_q <= excXNaN_uid393_rReal_uid16_fpComplexMulTest_q;
                WHEN OTHERS => excAN_uid424_rReal_uid16_fpComplexMulTest_q <= (others => '0');
            END CASE;
        END IF;
    END PROCESS;

    -- excRNaN2_uid514_rReal_uid16_fpComplexMulTest(LOGICAL,513)@18
    excRNaN2_uid514_rReal_uid16_fpComplexMulTest_q <= excAN_uid424_rReal_uid16_fpComplexMulTest_q or excBN_uid428_rReal_uid16_fpComplexMulTest_q;

    -- redist61_effSub_uid437_rReal_uid16_fpComplexMulTest_q_7(DELAY,1142)
    redist61_effSub_uid437_rReal_uid16_fpComplexMulTest_q_7 : dspba_delay
    GENERIC MAP ( width => 1, depth => 7, reset_kind => "ASYNC" )
    PORT MAP ( xin => effSub_uid437_rReal_uid16_fpComplexMulTest_q, xout => redist61_effSub_uid437_rReal_uid16_fpComplexMulTest_q_7_q, clk => clk, aclr => areset );

    -- redist71_excBI_uid427_rReal_uid16_fpComplexMulTest_q_1(DELAY,1152)
    redist71_excBI_uid427_rReal_uid16_fpComplexMulTest_q_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => excBI_uid427_rReal_uid16_fpComplexMulTest_q, xout => redist71_excBI_uid427_rReal_uid16_fpComplexMulTest_q_1_q, clk => clk, aclr => areset );

    -- redist73_excAI_uid423_rReal_uid16_fpComplexMulTest_q_1(DELAY,1154)
    redist73_excAI_uid423_rReal_uid16_fpComplexMulTest_q_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => excAI_uid423_rReal_uid16_fpComplexMulTest_q, xout => redist73_excAI_uid423_rReal_uid16_fpComplexMulTest_q_1_q, clk => clk, aclr => areset );

    -- excAIBISub_uid515_rReal_uid16_fpComplexMulTest(LOGICAL,514)@18
    excAIBISub_uid515_rReal_uid16_fpComplexMulTest_q <= redist73_excAI_uid423_rReal_uid16_fpComplexMulTest_q_1_q and redist71_excBI_uid427_rReal_uid16_fpComplexMulTest_q_1_q and redist61_effSub_uid437_rReal_uid16_fpComplexMulTest_q_7_q;

    -- excRNaN_uid516_rReal_uid16_fpComplexMulTest(LOGICAL,515)@18
    excRNaN_uid516_rReal_uid16_fpComplexMulTest_q <= excAIBISub_uid515_rReal_uid16_fpComplexMulTest_q or excRNaN2_uid514_rReal_uid16_fpComplexMulTest_q;

    -- invExcRNaN_uid528_rReal_uid16_fpComplexMulTest(LOGICAL,527)@18
    invExcRNaN_uid528_rReal_uid16_fpComplexMulTest_q <= not (excRNaN_uid516_rReal_uid16_fpComplexMulTest_q);

    -- signRPostExc_uid529_rReal_uid16_fpComplexMulTest(LOGICAL,528)@18 + 1
    signRPostExc_uid529_rReal_uid16_fpComplexMulTest_qi <= invExcRNaN_uid528_rReal_uid16_fpComplexMulTest_q and signRInfRZRReg_uid527_rReal_uid16_fpComplexMulTest_q;
    signRPostExc_uid529_rReal_uid16_fpComplexMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => signRPostExc_uid529_rReal_uid16_fpComplexMulTest_qi, xout => signRPostExc_uid529_rReal_uid16_fpComplexMulTest_q, clk => clk, aclr => areset );

    -- leftShiftStage1Idx3Rng3_uid863_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest(BITSELECT,862)@15
    leftShiftStage1Idx3Rng3_uid863_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_in <= leftShiftStage0_uid855_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_mfinal_q(24 downto 0);
    leftShiftStage1Idx3Rng3_uid863_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_b <= leftShiftStage1Idx3Rng3_uid863_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_in(24 downto 0);

    -- leftShiftStage1Idx3_uid864_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest(BITJOIN,863)@15
    leftShiftStage1Idx3_uid864_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_q <= leftShiftStage1Idx3Rng3_uid863_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_b & rightShiftStage1Idx3Pad3_uid814_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q;

    -- leftShiftStage1Idx2Rng2_uid860_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest(BITSELECT,859)@15
    leftShiftStage1Idx2Rng2_uid860_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_in <= leftShiftStage0_uid855_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_mfinal_q(25 downto 0);
    leftShiftStage1Idx2Rng2_uid860_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_b <= leftShiftStage1Idx2Rng2_uid860_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_in(25 downto 0);

    -- leftShiftStage1Idx2_uid861_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest(BITJOIN,860)@15
    leftShiftStage1Idx2_uid861_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_q <= leftShiftStage1Idx2Rng2_uid860_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_b & zero2b_uid386_rReal_uid16_fpComplexMulTest_q;

    -- leftShiftStage1Idx1Rng1_uid857_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest(BITSELECT,856)@15
    leftShiftStage1Idx1Rng1_uid857_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_in <= leftShiftStage0_uid855_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_mfinal_q(26 downto 0);
    leftShiftStage1Idx1Rng1_uid857_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_b <= leftShiftStage1Idx1Rng1_uid857_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_in(26 downto 0);

    -- leftShiftStage1Idx1_uid858_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest(BITJOIN,857)@15
    leftShiftStage1Idx1_uid858_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_q <= leftShiftStage1Idx1Rng1_uid857_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_b & GND_q;

    -- redist59_fracGRS_uid471_rReal_uid16_fpComplexMulTest_q_2(DELAY,1140)
    redist59_fracGRS_uid471_rReal_uid16_fpComplexMulTest_q_2 : dspba_delay
    GENERIC MAP ( width => 28, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => redist58_fracGRS_uid471_rReal_uid16_fpComplexMulTest_q_1_q, xout => redist59_fracGRS_uid471_rReal_uid16_fpComplexMulTest_q_2_q, clk => clk, aclr => areset );

    -- leftShiftStage0Idx6Rng24_uid851_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest(BITSELECT,850)@14
    leftShiftStage0Idx6Rng24_uid851_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_in <= redist59_fracGRS_uid471_rReal_uid16_fpComplexMulTest_q_2_q(3 downto 0);
    leftShiftStage0Idx6Rng24_uid851_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_b <= leftShiftStage0Idx6Rng24_uid851_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_in(3 downto 0);

    -- leftShiftStage0Idx6_uid852_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest(BITJOIN,851)@14
    leftShiftStage0Idx6_uid852_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_q <= leftShiftStage0Idx6Rng24_uid851_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_b & rightShiftStage0Idx3Pad24_uid793_alignmentShifter_uid451_rReal_uid16_fpComplexMulTest_q;

    -- leftShiftStage0Idx5Rng20_uid848_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest(BITSELECT,847)@14
    leftShiftStage0Idx5Rng20_uid848_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_in <= redist59_fracGRS_uid471_rReal_uid16_fpComplexMulTest_q_2_q(7 downto 0);
    leftShiftStage0Idx5Rng20_uid848_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_b <= leftShiftStage0Idx5Rng20_uid848_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_in(7 downto 0);

    -- leftShiftStage0Idx5_uid849_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest(BITJOIN,848)@14
    leftShiftStage0Idx5_uid849_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_q <= leftShiftStage0Idx5Rng20_uid848_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_b & leftShiftStage0Idx5Pad20_uid847_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_q;

    -- redist19_vStage_uid716_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_b_1(DELAY,1100)
    redist19_vStage_uid716_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_b_1 : dspba_delay
    GENERIC MAP ( width => 12, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => vStage_uid716_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_b, xout => redist19_vStage_uid716_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_b_1_q, clk => clk, aclr => areset );

    -- leftShiftStage0Idx4_uid846_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest(BITJOIN,845)@14
    leftShiftStage0Idx4_uid846_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_q <= redist19_vStage_uid716_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_b_1_q & zs_uid712_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q;

    -- leftShiftStageSel4Dto2_uid854_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_merged_bit_select(BITSELECT,1070)@14
    leftShiftStageSel4Dto2_uid854_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_merged_bit_select_b <= r_uid741_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q(4 downto 2);
    leftShiftStageSel4Dto2_uid854_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_merged_bit_select_c <= r_uid741_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q(1 downto 0);

    -- leftShiftStage0_uid855_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_selLSBs_merged_bit_select(BITSELECT,1079)@14
    leftShiftStage0_uid855_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_selLSBs_merged_bit_select_b <= leftShiftStageSel4Dto2_uid854_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_merged_bit_select_b(1 downto 0);
    leftShiftStage0_uid855_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_selLSBs_merged_bit_select_c <= leftShiftStageSel4Dto2_uid854_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_merged_bit_select_b(2 downto 2);

    -- leftShiftStage0_uid855_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_msplit_1(MUX,1042)@14 + 1
    leftShiftStage0_uid855_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_msplit_1_s <= leftShiftStage0_uid855_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_selLSBs_merged_bit_select_b;
    leftShiftStage0_uid855_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_msplit_1_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            leftShiftStage0_uid855_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_msplit_1_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            CASE (leftShiftStage0_uid855_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_msplit_1_s) IS
                WHEN "00" => leftShiftStage0_uid855_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_msplit_1_q <= leftShiftStage0Idx4_uid846_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_q;
                WHEN "01" => leftShiftStage0_uid855_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_msplit_1_q <= leftShiftStage0Idx5_uid849_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_q;
                WHEN "10" => leftShiftStage0_uid855_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_msplit_1_q <= leftShiftStage0Idx6_uid852_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_q;
                WHEN "11" => leftShiftStage0_uid855_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_msplit_1_q <= leftShiftStage0Idx7_uid853_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_q;
                WHEN OTHERS => leftShiftStage0_uid855_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_msplit_1_q <= (others => '0');
            END CASE;
        END IF;
    END PROCESS;

    -- leftShiftStage0Idx3Rng12_uid842_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest(BITSELECT,841)@14
    leftShiftStage0Idx3Rng12_uid842_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_in <= redist59_fracGRS_uid471_rReal_uid16_fpComplexMulTest_q_2_q(15 downto 0);
    leftShiftStage0Idx3Rng12_uid842_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_b <= leftShiftStage0Idx3Rng12_uid842_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_in(15 downto 0);

    -- leftShiftStage0Idx3_uid843_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest(BITJOIN,842)@14
    leftShiftStage0Idx3_uid843_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_q <= leftShiftStage0Idx3Rng12_uid842_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_b & leftShiftStage0Idx3Pad12_uid841_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_q;

    -- leftShiftStage0Idx2Rng8_uid839_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest(BITSELECT,838)@14
    leftShiftStage0Idx2Rng8_uid839_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_in <= redist59_fracGRS_uid471_rReal_uid16_fpComplexMulTest_q_2_q(19 downto 0);
    leftShiftStage0Idx2Rng8_uid839_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_b <= leftShiftStage0Idx2Rng8_uid839_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_in(19 downto 0);

    -- leftShiftStage0Idx2_uid840_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest(BITJOIN,839)@14
    leftShiftStage0Idx2_uid840_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_q <= leftShiftStage0Idx2Rng8_uid839_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_b & cstAllZWE_uid26_ac_uid6_fpComplexMulTest_q;

    -- leftShiftStage0Idx1Rng4_uid836_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest(BITSELECT,835)@14
    leftShiftStage0Idx1Rng4_uid836_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_in <= redist59_fracGRS_uid471_rReal_uid16_fpComplexMulTest_q_2_q(23 downto 0);
    leftShiftStage0Idx1Rng4_uid836_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_b <= leftShiftStage0Idx1Rng4_uid836_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_in(23 downto 0);

    -- leftShiftStage0Idx1_uid837_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest(BITJOIN,836)@14
    leftShiftStage0Idx1_uid837_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_q <= leftShiftStage0Idx1Rng4_uid836_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_b & zs_uid726_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q;

    -- leftShiftStage0_uid855_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_msplit_0(MUX,1041)@14 + 1
    leftShiftStage0_uid855_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_msplit_0_s <= leftShiftStage0_uid855_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_selLSBs_merged_bit_select_b;
    leftShiftStage0_uid855_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_msplit_0_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            leftShiftStage0_uid855_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_msplit_0_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            CASE (leftShiftStage0_uid855_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_msplit_0_s) IS
                WHEN "00" => leftShiftStage0_uid855_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_msplit_0_q <= redist59_fracGRS_uid471_rReal_uid16_fpComplexMulTest_q_2_q;
                WHEN "01" => leftShiftStage0_uid855_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_msplit_0_q <= leftShiftStage0Idx1_uid837_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_q;
                WHEN "10" => leftShiftStage0_uid855_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_msplit_0_q <= leftShiftStage0Idx2_uid840_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_q;
                WHEN "11" => leftShiftStage0_uid855_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_msplit_0_q <= leftShiftStage0Idx3_uid843_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_q;
                WHEN OTHERS => leftShiftStage0_uid855_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_msplit_0_q <= (others => '0');
            END CASE;
        END IF;
    END PROCESS;

    -- redist1_leftShiftStage0_uid855_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_selLSBs_merged_bit_select_c_1(DELAY,1082)
    redist1_leftShiftStage0_uid855_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_selLSBs_merged_bit_select_c_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => leftShiftStage0_uid855_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_selLSBs_merged_bit_select_c, xout => redist1_leftShiftStage0_uid855_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_selLSBs_merged_bit_select_c_1_q, clk => clk, aclr => areset );

    -- leftShiftStage0_uid855_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_mfinal(MUX,1043)@15
    leftShiftStage0_uid855_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_mfinal_s <= redist1_leftShiftStage0_uid855_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_selLSBs_merged_bit_select_c_1_q;
    leftShiftStage0_uid855_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_mfinal_combproc: PROCESS (leftShiftStage0_uid855_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_mfinal_s, leftShiftStage0_uid855_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_msplit_0_q, leftShiftStage0_uid855_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_msplit_1_q)
    BEGIN
        CASE (leftShiftStage0_uid855_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_mfinal_s) IS
            WHEN "0" => leftShiftStage0_uid855_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_mfinal_q <= leftShiftStage0_uid855_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_msplit_0_q;
            WHEN "1" => leftShiftStage0_uid855_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_mfinal_q <= leftShiftStage0_uid855_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_msplit_1_q;
            WHEN OTHERS => leftShiftStage0_uid855_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_mfinal_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist5_leftShiftStageSel4Dto2_uid854_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_merged_bit_select_c_1(DELAY,1086)
    redist5_leftShiftStageSel4Dto2_uid854_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_merged_bit_select_c_1 : dspba_delay
    GENERIC MAP ( width => 2, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => leftShiftStageSel4Dto2_uid854_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_merged_bit_select_c, xout => redist5_leftShiftStageSel4Dto2_uid854_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_merged_bit_select_c_1_q, clk => clk, aclr => areset );

    -- leftShiftStage1_uid866_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest(MUX,865)@15
    leftShiftStage1_uid866_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_s <= redist5_leftShiftStageSel4Dto2_uid854_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_merged_bit_select_c_1_q;
    leftShiftStage1_uid866_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_combproc: PROCESS (leftShiftStage1_uid866_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_s, leftShiftStage0_uid855_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_mfinal_q, leftShiftStage1Idx1_uid858_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_q, leftShiftStage1Idx2_uid861_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_q, leftShiftStage1Idx3_uid864_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_q)
    BEGIN
        CASE (leftShiftStage1_uid866_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_s) IS
            WHEN "00" => leftShiftStage1_uid866_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_q <= leftShiftStage0_uid855_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_mfinal_q;
            WHEN "01" => leftShiftStage1_uid866_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_q <= leftShiftStage1Idx1_uid858_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_q;
            WHEN "10" => leftShiftStage1_uid866_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_q <= leftShiftStage1Idx2_uid861_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_q;
            WHEN "11" => leftShiftStage1_uid866_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_q <= leftShiftStage1Idx3_uid864_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_q;
            WHEN OTHERS => leftShiftStage1_uid866_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- LSB_uid484_rReal_uid16_fpComplexMulTest(BITSELECT,483)@15
    LSB_uid484_rReal_uid16_fpComplexMulTest_in <= STD_LOGIC_VECTOR(leftShiftStage1_uid866_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_q(4 downto 0));
    LSB_uid484_rReal_uid16_fpComplexMulTest_b <= STD_LOGIC_VECTOR(LSB_uid484_rReal_uid16_fpComplexMulTest_in(4 downto 4));

    -- Guard_uid483_rReal_uid16_fpComplexMulTest(BITSELECT,482)@15
    Guard_uid483_rReal_uid16_fpComplexMulTest_in <= STD_LOGIC_VECTOR(leftShiftStage1_uid866_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_q(3 downto 0));
    Guard_uid483_rReal_uid16_fpComplexMulTest_b <= STD_LOGIC_VECTOR(Guard_uid483_rReal_uid16_fpComplexMulTest_in(3 downto 3));

    -- Round_uid482_rReal_uid16_fpComplexMulTest(BITSELECT,481)@15
    Round_uid482_rReal_uid16_fpComplexMulTest_in <= STD_LOGIC_VECTOR(leftShiftStage1_uid866_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_q(2 downto 0));
    Round_uid482_rReal_uid16_fpComplexMulTest_b <= STD_LOGIC_VECTOR(Round_uid482_rReal_uid16_fpComplexMulTest_in(2 downto 2));

    -- Sticky1_uid481_rReal_uid16_fpComplexMulTest(BITSELECT,480)@15
    Sticky1_uid481_rReal_uid16_fpComplexMulTest_in <= STD_LOGIC_VECTOR(leftShiftStage1_uid866_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_q(1 downto 0));
    Sticky1_uid481_rReal_uid16_fpComplexMulTest_b <= STD_LOGIC_VECTOR(Sticky1_uid481_rReal_uid16_fpComplexMulTest_in(1 downto 1));

    -- Sticky0_uid480_rReal_uid16_fpComplexMulTest(BITSELECT,479)@15
    Sticky0_uid480_rReal_uid16_fpComplexMulTest_in <= STD_LOGIC_VECTOR(leftShiftStage1_uid866_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_q(0 downto 0));
    Sticky0_uid480_rReal_uid16_fpComplexMulTest_b <= STD_LOGIC_VECTOR(Sticky0_uid480_rReal_uid16_fpComplexMulTest_in(0 downto 0));

    -- rndBitCond_uid485_rReal_uid16_fpComplexMulTest(BITJOIN,484)@15
    rndBitCond_uid485_rReal_uid16_fpComplexMulTest_q <= LSB_uid484_rReal_uid16_fpComplexMulTest_b & Guard_uid483_rReal_uid16_fpComplexMulTest_b & Round_uid482_rReal_uid16_fpComplexMulTest_b & Sticky1_uid481_rReal_uid16_fpComplexMulTest_b & Sticky0_uid480_rReal_uid16_fpComplexMulTest_b;

    -- rBi_uid487_rReal_uid16_fpComplexMulTest(LOGICAL,486)@15 + 1
    rBi_uid487_rReal_uid16_fpComplexMulTest_qi <= "1" WHEN rndBitCond_uid485_rReal_uid16_fpComplexMulTest_q = cRBit_uid486_rReal_uid16_fpComplexMulTest_q ELSE "0";
    rBi_uid487_rReal_uid16_fpComplexMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => rBi_uid487_rReal_uid16_fpComplexMulTest_qi, xout => rBi_uid487_rReal_uid16_fpComplexMulTest_q, clk => clk, aclr => areset );

    -- roundBit_uid488_rReal_uid16_fpComplexMulTest(LOGICAL,487)@16
    roundBit_uid488_rReal_uid16_fpComplexMulTest_q <= not (rBi_uid487_rReal_uid16_fpComplexMulTest_q);

    -- redist68_expA_uid431_rReal_uid16_fpComplexMulTest_b_6(DELAY,1149)
    redist68_expA_uid431_rReal_uid16_fpComplexMulTest_b_6 : dspba_delay
    GENERIC MAP ( width => 8, depth => 6, reset_kind => "ASYNC" )
    PORT MAP ( xin => expA_uid431_rReal_uid16_fpComplexMulTest_b, xout => redist68_expA_uid431_rReal_uid16_fpComplexMulTest_b_6_q, clk => clk, aclr => areset );

    -- expInc_uid478_rReal_uid16_fpComplexMulTest(ADD,477)@14
    expInc_uid478_rReal_uid16_fpComplexMulTest_a <= STD_LOGIC_VECTOR("0" & redist68_expA_uid431_rReal_uid16_fpComplexMulTest_b_6_q);
    expInc_uid478_rReal_uid16_fpComplexMulTest_b <= STD_LOGIC_VECTOR("0" & oneCST_uid477_rReal_uid16_fpComplexMulTest_q);
    expInc_uid478_rReal_uid16_fpComplexMulTest_o <= STD_LOGIC_VECTOR(UNSIGNED(expInc_uid478_rReal_uid16_fpComplexMulTest_a) + UNSIGNED(expInc_uid478_rReal_uid16_fpComplexMulTest_b));
    expInc_uid478_rReal_uid16_fpComplexMulTest_q <= expInc_uid478_rReal_uid16_fpComplexMulTest_o(8 downto 0);

    -- expPostNorm_uid479_rReal_uid16_fpComplexMulTest(SUB,478)@14 + 1
    expPostNorm_uid479_rReal_uid16_fpComplexMulTest_a <= STD_LOGIC_VECTOR("0" & expInc_uid478_rReal_uid16_fpComplexMulTest_q);
    expPostNorm_uid479_rReal_uid16_fpComplexMulTest_b <= STD_LOGIC_VECTOR("00000" & r_uid741_lzCountVal_uid472_rReal_uid16_fpComplexMulTest_q);
    expPostNorm_uid479_rReal_uid16_fpComplexMulTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            expPostNorm_uid479_rReal_uid16_fpComplexMulTest_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            expPostNorm_uid479_rReal_uid16_fpComplexMulTest_o <= STD_LOGIC_VECTOR(UNSIGNED(expPostNorm_uid479_rReal_uid16_fpComplexMulTest_a) - UNSIGNED(expPostNorm_uid479_rReal_uid16_fpComplexMulTest_b));
        END IF;
    END PROCESS;
    expPostNorm_uid479_rReal_uid16_fpComplexMulTest_q <= expPostNorm_uid479_rReal_uid16_fpComplexMulTest_o(9 downto 0);

    -- redist56_expPostNorm_uid479_rReal_uid16_fpComplexMulTest_q_2(DELAY,1137)
    redist56_expPostNorm_uid479_rReal_uid16_fpComplexMulTest_q_2 : dspba_delay
    GENERIC MAP ( width => 10, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => expPostNorm_uid479_rReal_uid16_fpComplexMulTest_q, xout => redist56_expPostNorm_uid479_rReal_uid16_fpComplexMulTest_q_2_q, clk => clk, aclr => areset );

    -- fracPostNorm_uid476_rReal_uid16_fpComplexMulTest(BITSELECT,475)@15
    fracPostNorm_uid476_rReal_uid16_fpComplexMulTest_b <= leftShiftStage1_uid866_fracPostNormExt_uid475_rReal_uid16_fpComplexMulTest_q(27 downto 1);

    -- fracPostNormRndRange_uid489_rReal_uid16_fpComplexMulTest(BITSELECT,488)@15
    fracPostNormRndRange_uid489_rReal_uid16_fpComplexMulTest_in <= fracPostNorm_uid476_rReal_uid16_fpComplexMulTest_b(25 downto 0);
    fracPostNormRndRange_uid489_rReal_uid16_fpComplexMulTest_b <= fracPostNormRndRange_uid489_rReal_uid16_fpComplexMulTest_in(25 downto 2);

    -- redist55_fracPostNormRndRange_uid489_rReal_uid16_fpComplexMulTest_b_1(DELAY,1136)
    redist55_fracPostNormRndRange_uid489_rReal_uid16_fpComplexMulTest_b_1 : dspba_delay
    GENERIC MAP ( width => 24, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => fracPostNormRndRange_uid489_rReal_uid16_fpComplexMulTest_b, xout => redist55_fracPostNormRndRange_uid489_rReal_uid16_fpComplexMulTest_b_1_q, clk => clk, aclr => areset );

    -- expFracR_uid490_rReal_uid16_fpComplexMulTest(BITJOIN,489)@16
    expFracR_uid490_rReal_uid16_fpComplexMulTest_q <= redist56_expPostNorm_uid479_rReal_uid16_fpComplexMulTest_q_2_q & redist55_fracPostNormRndRange_uid489_rReal_uid16_fpComplexMulTest_b_1_q;

    -- rndExpFrac_uid491_rReal_uid16_fpComplexMulTest(ADD,490)@16 + 1
    rndExpFrac_uid491_rReal_uid16_fpComplexMulTest_a <= STD_LOGIC_VECTOR("0" & expFracR_uid490_rReal_uid16_fpComplexMulTest_q);
    rndExpFrac_uid491_rReal_uid16_fpComplexMulTest_b <= STD_LOGIC_VECTOR("0000000000000000000000000000000000" & roundBit_uid488_rReal_uid16_fpComplexMulTest_q);
    rndExpFrac_uid491_rReal_uid16_fpComplexMulTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            rndExpFrac_uid491_rReal_uid16_fpComplexMulTest_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            rndExpFrac_uid491_rReal_uid16_fpComplexMulTest_o <= STD_LOGIC_VECTOR(UNSIGNED(rndExpFrac_uid491_rReal_uid16_fpComplexMulTest_a) + UNSIGNED(rndExpFrac_uid491_rReal_uid16_fpComplexMulTest_b));
        END IF;
    END PROCESS;
    rndExpFrac_uid491_rReal_uid16_fpComplexMulTest_q <= rndExpFrac_uid491_rReal_uid16_fpComplexMulTest_o(34 downto 0);

    -- expRPreExc_uid504_rReal_uid16_fpComplexMulTest(BITSELECT,503)@17
    expRPreExc_uid504_rReal_uid16_fpComplexMulTest_in <= rndExpFrac_uid491_rReal_uid16_fpComplexMulTest_q(31 downto 0);
    expRPreExc_uid504_rReal_uid16_fpComplexMulTest_b <= expRPreExc_uid504_rReal_uid16_fpComplexMulTest_in(31 downto 24);

    -- redist53_expRPreExc_uid504_rReal_uid16_fpComplexMulTest_b_2(DELAY,1134)
    redist53_expRPreExc_uid504_rReal_uid16_fpComplexMulTest_b_2 : dspba_delay
    GENERIC MAP ( width => 8, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => expRPreExc_uid504_rReal_uid16_fpComplexMulTest_b, xout => redist53_expRPreExc_uid504_rReal_uid16_fpComplexMulTest_b_2_q, clk => clk, aclr => areset );

    -- rndExpFracOvfBits_uid496_rReal_uid16_fpComplexMulTest(BITSELECT,495)@17
    rndExpFracOvfBits_uid496_rReal_uid16_fpComplexMulTest_in <= rndExpFrac_uid491_rReal_uid16_fpComplexMulTest_q(33 downto 0);
    rndExpFracOvfBits_uid496_rReal_uid16_fpComplexMulTest_b <= rndExpFracOvfBits_uid496_rReal_uid16_fpComplexMulTest_in(33 downto 32);

    -- rOvfExtraBits_uid497_rReal_uid16_fpComplexMulTest(LOGICAL,496)@17
    rOvfExtraBits_uid497_rReal_uid16_fpComplexMulTest_q <= "1" WHEN rndExpFracOvfBits_uid496_rReal_uid16_fpComplexMulTest_b = one2b_uid387_rReal_uid16_fpComplexMulTest_q ELSE "0";

    -- rndExp_uid493_rReal_uid16_fpComplexMulTest(BITSELECT,492)@17
    rndExp_uid493_rReal_uid16_fpComplexMulTest_in <= rndExpFrac_uid491_rReal_uid16_fpComplexMulTest_q(33 downto 0);
    rndExp_uid493_rReal_uid16_fpComplexMulTest_b <= rndExp_uid493_rReal_uid16_fpComplexMulTest_in(33 downto 24);

    -- rOvfEQMax_uid494_rReal_uid16_fpComplexMulTest(LOGICAL,493)@17
    rOvfEQMax_uid494_rReal_uid16_fpComplexMulTest_q <= "1" WHEN rndExp_uid493_rReal_uid16_fpComplexMulTest_b = wEP2AllOwE_uid492_rReal_uid16_fpComplexMulTest_q ELSE "0";

    -- rOvf_uid498_rReal_uid16_fpComplexMulTest(LOGICAL,497)@17
    rOvf_uid498_rReal_uid16_fpComplexMulTest_q <= rOvfEQMax_uid494_rReal_uid16_fpComplexMulTest_q or rOvfExtraBits_uid497_rReal_uid16_fpComplexMulTest_q;

    -- regInputs_uid505_rReal_uid16_fpComplexMulTest(LOGICAL,504)@17
    regInputs_uid505_rReal_uid16_fpComplexMulTest_q <= excAR_uid425_rReal_uid16_fpComplexMulTest_q and excBR_uid429_rReal_uid16_fpComplexMulTest_q;

    -- aZeroBRegFPLib_uid509_rReal_uid16_fpComplexMulTest(LOGICAL,508)@17
    aZeroBRegFPLib_uid509_rReal_uid16_fpComplexMulTest_q <= redist72_excAZ_uid426_rReal_uid16_fpComplexMulTest_q_9_q and excBR_uid429_rReal_uid16_fpComplexMulTest_q;

    -- aRegBZeroFPLib_uid508_rReal_uid16_fpComplexMulTest(LOGICAL,507)@17
    aRegBZeroFPLib_uid508_rReal_uid16_fpComplexMulTest_q <= excAR_uid425_rReal_uid16_fpComplexMulTest_q and redist70_excBZ_uid430_rReal_uid16_fpComplexMulTest_q_9_q;

    -- fpLibRegInputs_uid510_rReal_uid16_fpComplexMulTest(LOGICAL,509)@17
    fpLibRegInputs_uid510_rReal_uid16_fpComplexMulTest_q <= aRegBZeroFPLib_uid508_rReal_uid16_fpComplexMulTest_q or aZeroBRegFPLib_uid509_rReal_uid16_fpComplexMulTest_q or regInputs_uid505_rReal_uid16_fpComplexMulTest_q;

    -- rInfOvf_uid511_rReal_uid16_fpComplexMulTest(LOGICAL,510)@17 + 1
    rInfOvf_uid511_rReal_uid16_fpComplexMulTest_qi <= fpLibRegInputs_uid510_rReal_uid16_fpComplexMulTest_q and rOvf_uid498_rReal_uid16_fpComplexMulTest_q;
    rInfOvf_uid511_rReal_uid16_fpComplexMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => rInfOvf_uid511_rReal_uid16_fpComplexMulTest_qi, xout => rInfOvf_uid511_rReal_uid16_fpComplexMulTest_q, clk => clk, aclr => areset );

    -- excRInfVInC_uid512_rReal_uid16_fpComplexMulTest(BITJOIN,511)@18
    excRInfVInC_uid512_rReal_uid16_fpComplexMulTest_q <= rInfOvf_uid511_rReal_uid16_fpComplexMulTest_q & excBN_uid428_rReal_uid16_fpComplexMulTest_q & excAN_uid424_rReal_uid16_fpComplexMulTest_q & redist71_excBI_uid427_rReal_uid16_fpComplexMulTest_q_1_q & redist73_excAI_uid423_rReal_uid16_fpComplexMulTest_q_1_q & redist61_effSub_uid437_rReal_uid16_fpComplexMulTest_q_7_q;

    -- excRInf_uid513_rReal_uid16_fpComplexMulTest(LOOKUP,512)@18
    excRInf_uid513_rReal_uid16_fpComplexMulTest_combproc: PROCESS (excRInfVInC_uid512_rReal_uid16_fpComplexMulTest_q)
    BEGIN
        -- Begin reserved scope level
        CASE (excRInfVInC_uid512_rReal_uid16_fpComplexMulTest_q) IS
            WHEN "000000" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "0";
            WHEN "000001" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "0";
            WHEN "000010" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "1";
            WHEN "000011" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "1";
            WHEN "000100" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "1";
            WHEN "000101" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "1";
            WHEN "000110" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "1";
            WHEN "000111" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "0";
            WHEN "001000" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "0";
            WHEN "001001" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "0";
            WHEN "001010" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "0";
            WHEN "001011" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "0";
            WHEN "001100" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "0";
            WHEN "001101" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "0";
            WHEN "001110" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "0";
            WHEN "001111" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "0";
            WHEN "010000" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "0";
            WHEN "010001" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "0";
            WHEN "010010" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "0";
            WHEN "010011" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "0";
            WHEN "010100" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "0";
            WHEN "010101" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "0";
            WHEN "010110" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "0";
            WHEN "010111" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "0";
            WHEN "011000" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "0";
            WHEN "011001" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "0";
            WHEN "011010" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "0";
            WHEN "011011" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "0";
            WHEN "011100" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "0";
            WHEN "011101" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "0";
            WHEN "011110" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "0";
            WHEN "011111" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "0";
            WHEN "100000" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "1";
            WHEN "100001" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "1";
            WHEN "100010" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "0";
            WHEN "100011" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "0";
            WHEN "100100" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "0";
            WHEN "100101" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "0";
            WHEN "100110" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "0";
            WHEN "100111" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "0";
            WHEN "101000" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "0";
            WHEN "101001" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "0";
            WHEN "101010" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "0";
            WHEN "101011" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "0";
            WHEN "101100" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "0";
            WHEN "101101" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "0";
            WHEN "101110" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "0";
            WHEN "101111" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "0";
            WHEN "110000" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "0";
            WHEN "110001" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "0";
            WHEN "110010" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "0";
            WHEN "110011" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "0";
            WHEN "110100" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "0";
            WHEN "110101" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "0";
            WHEN "110110" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "0";
            WHEN "110111" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "0";
            WHEN "111000" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "0";
            WHEN "111001" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "0";
            WHEN "111010" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "0";
            WHEN "111011" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "0";
            WHEN "111100" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "0";
            WHEN "111101" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "0";
            WHEN "111110" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "0";
            WHEN "111111" => excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= "0";
            WHEN OTHERS => -- unreachable
                           excRInf_uid513_rReal_uid16_fpComplexMulTest_q <= (others => '-');
        END CASE;
        -- End reserved scope level
    END PROCESS;

    -- rUdfExtraBit_uid501_rReal_uid16_fpComplexMulTest(BITSELECT,500)@17
    rUdfExtraBit_uid501_rReal_uid16_fpComplexMulTest_in <= STD_LOGIC_VECTOR(rndExpFrac_uid491_rReal_uid16_fpComplexMulTest_q(33 downto 0));
    rUdfExtraBit_uid501_rReal_uid16_fpComplexMulTest_b <= STD_LOGIC_VECTOR(rUdfExtraBit_uid501_rReal_uid16_fpComplexMulTest_in(33 downto 33));

    -- rUdfEQMin_uid500_rReal_uid16_fpComplexMulTest(LOGICAL,499)@17
    rUdfEQMin_uid500_rReal_uid16_fpComplexMulTest_q <= "1" WHEN rndExp_uid493_rReal_uid16_fpComplexMulTest_b = wEP2AllZ_uid499_rReal_uid16_fpComplexMulTest_q ELSE "0";

    -- rUdf_uid502_rReal_uid16_fpComplexMulTest(LOGICAL,501)@17
    rUdf_uid502_rReal_uid16_fpComplexMulTest_q <= rUdfEQMin_uid500_rReal_uid16_fpComplexMulTest_q or rUdfExtraBit_uid501_rReal_uid16_fpComplexMulTest_b;

    -- excRZeroVInC_uid506_rReal_uid16_fpComplexMulTest(BITJOIN,505)@17
    excRZeroVInC_uid506_rReal_uid16_fpComplexMulTest_q <= redist57_aMinusA_uid474_rReal_uid16_fpComplexMulTest_q_3_q & rUdf_uid502_rReal_uid16_fpComplexMulTest_q & regInputs_uid505_rReal_uid16_fpComplexMulTest_q & redist70_excBZ_uid430_rReal_uid16_fpComplexMulTest_q_9_q & redist72_excAZ_uid426_rReal_uid16_fpComplexMulTest_q_9_q;

    -- excRZero_uid507_rReal_uid16_fpComplexMulTest(LOOKUP,506)@17 + 1
    excRZero_uid507_rReal_uid16_fpComplexMulTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            excRZero_uid507_rReal_uid16_fpComplexMulTest_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            CASE (excRZeroVInC_uid506_rReal_uid16_fpComplexMulTest_q) IS
                WHEN "00000" => excRZero_uid507_rReal_uid16_fpComplexMulTest_q <= "0";
                WHEN "00001" => excRZero_uid507_rReal_uid16_fpComplexMulTest_q <= "0";
                WHEN "00010" => excRZero_uid507_rReal_uid16_fpComplexMulTest_q <= "0";
                WHEN "00011" => excRZero_uid507_rReal_uid16_fpComplexMulTest_q <= "1";
                WHEN "00100" => excRZero_uid507_rReal_uid16_fpComplexMulTest_q <= "0";
                WHEN "00101" => excRZero_uid507_rReal_uid16_fpComplexMulTest_q <= "0";
                WHEN "00110" => excRZero_uid507_rReal_uid16_fpComplexMulTest_q <= "0";
                WHEN "00111" => excRZero_uid507_rReal_uid16_fpComplexMulTest_q <= "0";
                WHEN "01000" => excRZero_uid507_rReal_uid16_fpComplexMulTest_q <= "0";
                WHEN "01001" => excRZero_uid507_rReal_uid16_fpComplexMulTest_q <= "0";
                WHEN "01010" => excRZero_uid507_rReal_uid16_fpComplexMulTest_q <= "0";
                WHEN "01011" => excRZero_uid507_rReal_uid16_fpComplexMulTest_q <= "1";
                WHEN "01100" => excRZero_uid507_rReal_uid16_fpComplexMulTest_q <= "1";
                WHEN "01101" => excRZero_uid507_rReal_uid16_fpComplexMulTest_q <= "0";
                WHEN "01110" => excRZero_uid507_rReal_uid16_fpComplexMulTest_q <= "0";
                WHEN "01111" => excRZero_uid507_rReal_uid16_fpComplexMulTest_q <= "0";
                WHEN "10000" => excRZero_uid507_rReal_uid16_fpComplexMulTest_q <= "0";
                WHEN "10001" => excRZero_uid507_rReal_uid16_fpComplexMulTest_q <= "0";
                WHEN "10010" => excRZero_uid507_rReal_uid16_fpComplexMulTest_q <= "0";
                WHEN "10011" => excRZero_uid507_rReal_uid16_fpComplexMulTest_q <= "1";
                WHEN "10100" => excRZero_uid507_rReal_uid16_fpComplexMulTest_q <= "1";
                WHEN "10101" => excRZero_uid507_rReal_uid16_fpComplexMulTest_q <= "0";
                WHEN "10110" => excRZero_uid507_rReal_uid16_fpComplexMulTest_q <= "0";
                WHEN "10111" => excRZero_uid507_rReal_uid16_fpComplexMulTest_q <= "0";
                WHEN "11000" => excRZero_uid507_rReal_uid16_fpComplexMulTest_q <= "0";
                WHEN "11001" => excRZero_uid507_rReal_uid16_fpComplexMulTest_q <= "0";
                WHEN "11010" => excRZero_uid507_rReal_uid16_fpComplexMulTest_q <= "0";
                WHEN "11011" => excRZero_uid507_rReal_uid16_fpComplexMulTest_q <= "1";
                WHEN "11100" => excRZero_uid507_rReal_uid16_fpComplexMulTest_q <= "1";
                WHEN "11101" => excRZero_uid507_rReal_uid16_fpComplexMulTest_q <= "0";
                WHEN "11110" => excRZero_uid507_rReal_uid16_fpComplexMulTest_q <= "0";
                WHEN "11111" => excRZero_uid507_rReal_uid16_fpComplexMulTest_q <= "0";
                WHEN OTHERS => -- unreachable
                               excRZero_uid507_rReal_uid16_fpComplexMulTest_q <= (others => '-');
            END CASE;
        END IF;
    END PROCESS;

    -- concExc_uid517_rReal_uid16_fpComplexMulTest(BITJOIN,516)@18
    concExc_uid517_rReal_uid16_fpComplexMulTest_q <= excRNaN_uid516_rReal_uid16_fpComplexMulTest_q & excRInf_uid513_rReal_uid16_fpComplexMulTest_q & excRZero_uid507_rReal_uid16_fpComplexMulTest_q;

    -- excREnc_uid518_rReal_uid16_fpComplexMulTest(LOOKUP,517)@18 + 1
    excREnc_uid518_rReal_uid16_fpComplexMulTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            excREnc_uid518_rReal_uid16_fpComplexMulTest_q <= "01";
        ELSIF (clk'EVENT AND clk = '1') THEN
            CASE (concExc_uid517_rReal_uid16_fpComplexMulTest_q) IS
                WHEN "000" => excREnc_uid518_rReal_uid16_fpComplexMulTest_q <= "01";
                WHEN "001" => excREnc_uid518_rReal_uid16_fpComplexMulTest_q <= "00";
                WHEN "010" => excREnc_uid518_rReal_uid16_fpComplexMulTest_q <= "10";
                WHEN "011" => excREnc_uid518_rReal_uid16_fpComplexMulTest_q <= "10";
                WHEN "100" => excREnc_uid518_rReal_uid16_fpComplexMulTest_q <= "11";
                WHEN "101" => excREnc_uid518_rReal_uid16_fpComplexMulTest_q <= "11";
                WHEN "110" => excREnc_uid518_rReal_uid16_fpComplexMulTest_q <= "11";
                WHEN "111" => excREnc_uid518_rReal_uid16_fpComplexMulTest_q <= "11";
                WHEN OTHERS => -- unreachable
                               excREnc_uid518_rReal_uid16_fpComplexMulTest_q <= (others => '-');
            END CASE;
        END IF;
    END PROCESS;

    -- expRPostExc_uid537_rReal_uid16_fpComplexMulTest(MUX,536)@19
    expRPostExc_uid537_rReal_uid16_fpComplexMulTest_s <= excREnc_uid518_rReal_uid16_fpComplexMulTest_q;
    expRPostExc_uid537_rReal_uid16_fpComplexMulTest_combproc: PROCESS (expRPostExc_uid537_rReal_uid16_fpComplexMulTest_s, cstAllZWE_uid26_ac_uid6_fpComplexMulTest_q, redist53_expRPreExc_uid504_rReal_uid16_fpComplexMulTest_b_2_q, cstAllOWE_uid24_ac_uid6_fpComplexMulTest_q)
    BEGIN
        CASE (expRPostExc_uid537_rReal_uid16_fpComplexMulTest_s) IS
            WHEN "00" => expRPostExc_uid537_rReal_uid16_fpComplexMulTest_q <= cstAllZWE_uid26_ac_uid6_fpComplexMulTest_q;
            WHEN "01" => expRPostExc_uid537_rReal_uid16_fpComplexMulTest_q <= redist53_expRPreExc_uid504_rReal_uid16_fpComplexMulTest_b_2_q;
            WHEN "10" => expRPostExc_uid537_rReal_uid16_fpComplexMulTest_q <= cstAllOWE_uid24_ac_uid6_fpComplexMulTest_q;
            WHEN "11" => expRPostExc_uid537_rReal_uid16_fpComplexMulTest_q <= cstAllOWE_uid24_ac_uid6_fpComplexMulTest_q;
            WHEN OTHERS => expRPostExc_uid537_rReal_uid16_fpComplexMulTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- fracRPreExc_uid503_rReal_uid16_fpComplexMulTest(BITSELECT,502)@17
    fracRPreExc_uid503_rReal_uid16_fpComplexMulTest_in <= rndExpFrac_uid491_rReal_uid16_fpComplexMulTest_q(23 downto 0);
    fracRPreExc_uid503_rReal_uid16_fpComplexMulTest_b <= fracRPreExc_uid503_rReal_uid16_fpComplexMulTest_in(23 downto 1);

    -- redist54_fracRPreExc_uid503_rReal_uid16_fpComplexMulTest_b_2(DELAY,1135)
    redist54_fracRPreExc_uid503_rReal_uid16_fpComplexMulTest_b_2 : dspba_delay
    GENERIC MAP ( width => 23, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => fracRPreExc_uid503_rReal_uid16_fpComplexMulTest_b, xout => redist54_fracRPreExc_uid503_rReal_uid16_fpComplexMulTest_b_2_q, clk => clk, aclr => areset );

    -- fracRPostExc_uid533_rReal_uid16_fpComplexMulTest(MUX,532)@19
    fracRPostExc_uid533_rReal_uid16_fpComplexMulTest_s <= excREnc_uid518_rReal_uid16_fpComplexMulTest_q;
    fracRPostExc_uid533_rReal_uid16_fpComplexMulTest_combproc: PROCESS (fracRPostExc_uid533_rReal_uid16_fpComplexMulTest_s, cstZeroWF_uid25_ac_uid6_fpComplexMulTest_q, redist54_fracRPreExc_uid503_rReal_uid16_fpComplexMulTest_b_2_q, oneFracRPostExc2_uid530_rReal_uid16_fpComplexMulTest_q)
    BEGIN
        CASE (fracRPostExc_uid533_rReal_uid16_fpComplexMulTest_s) IS
            WHEN "00" => fracRPostExc_uid533_rReal_uid16_fpComplexMulTest_q <= cstZeroWF_uid25_ac_uid6_fpComplexMulTest_q;
            WHEN "01" => fracRPostExc_uid533_rReal_uid16_fpComplexMulTest_q <= redist54_fracRPreExc_uid503_rReal_uid16_fpComplexMulTest_b_2_q;
            WHEN "10" => fracRPostExc_uid533_rReal_uid16_fpComplexMulTest_q <= cstZeroWF_uid25_ac_uid6_fpComplexMulTest_q;
            WHEN "11" => fracRPostExc_uid533_rReal_uid16_fpComplexMulTest_q <= oneFracRPostExc2_uid530_rReal_uid16_fpComplexMulTest_q;
            WHEN OTHERS => fracRPostExc_uid533_rReal_uid16_fpComplexMulTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- R_uid538_rReal_uid16_fpComplexMulTest(BITJOIN,537)@19
    R_uid538_rReal_uid16_fpComplexMulTest_q <= signRPostExc_uid529_rReal_uid16_fpComplexMulTest_q & expRPostExc_uid537_rReal_uid16_fpComplexMulTest_q & fracRPostExc_uid533_rReal_uid16_fpComplexMulTest_q;

    -- xOut(GPOUT,4)@19
    q <= R_uid538_rReal_uid16_fpComplexMulTest_q;
    r <= R_uid698_rImag_uid17_fpComplexMulTest_q;

END normal;

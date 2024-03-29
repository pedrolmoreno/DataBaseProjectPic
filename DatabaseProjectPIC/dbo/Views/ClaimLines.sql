﻿
CREATE VIEW [dbo].[ClaimLines]
AS
SELECT        CLAIM_ID, LINE, LINE_STATUS, PAYOR_ID, REGION_CODE, GROUP_ID, PLAN_ID, SPEC_FLAG, SPECIALTY_CODE, NETWORK_FLAG, CASH_CODE, EXP_CODE, AP_CODE, AUTH_ID, REFERRAL_ID, THIRD_PARTY_LINE_ID, 
                         RENDERING_PROVIDER_ID, PURCHASED_SVC_PROVIDER_ID, SUPERVISING_PROVIDER_ID, ORDERING_PROVIDER_ID, PRIOR_LINE_STATUS, EXCEPTION_CODE_01, EXCEPTION_CODE_02, EXCEPTION_CODE_03, 
                         EXCEPTION_CODE_04, EXCEPTION_CODE_05, EXCEPTION_OVERRIDE, PEND_OVERRIDE, RESUBMISSION_CODE, CAP_FLAG, LINE_CHARGE_AMOUNT, LINE_POINT, LINE_OVERRIDE_TYPE, ACCEPTED_AMOUNT, 
                         ACCEPTED_AMOUNT_OVERRIDE, ADJUSTED_AMOUNT, AMOUNT_PAID, COPAY_OVERRIDE_AMOUNT, COPAY_OVERRIDE_IND, COPAY_APPLIED_AMOUNT, COINS_APPLIED_AMOUNT, COINS_OVERRIDE_IND, 
                         DEDUCTIBLE_APPLIED_AMOUNT, DEDUCTIBLE_OVERRIDE_IND, NON_COVERED_AMOUNT, UNIT_PRICE_AMOUNT, UNITS, PRICING_TYPE, PRIMARY_PYMT_AMOUNT, PRIMARY_PYMT_OVERRIDE, 
                         PROVIDER_WITHHOLD_AMOUNT, RVS_AMOUNT, FS_PERCENT, FS_TYPE_CODE, SERVICE_FROM_DATE, SERVICE_TO_DATE, SERVICE_TYPE_CODE, SERVICE_TYPE_OVERRIDE, TOS_CODE, POS_CODE, DATE_PROCESSED, 
                         CLOSEOUT_DATE, PROCEDURE_CODE, MODIFIER_CODE_01, MODIFIER_CODE_02, MODIFIER_CODE_03, MODIFIER_CODE_04, DIAGNOSIS_REF_01, DIAGNOSIS_REF_02, DIAGNOSIS_REF_03, DIAGNOSIS_REF_04, 
                         DIAGNOSIS_REF_05, DIAGNOSIS_REF_06, DIAGNOSIS_REF_07, DIAGNOSIS_REF_08, ANES_DIAG_UNIT, ANES_DIVISOR, ANES_MINUTES, ANES_RATE, ANES_RISK_UNIT, BENEFIT_LVL, BENEFIT_LVL_OVERRIDE, 
                         BENEFIT_PLN_ERR_OVERRIDE, COB, EMERGENCY, EPSDT, ESRD, APPLIED_MBA_EDITS, SHAD_ACCEPTED_AMOUNT, SHAD_COINS_AMOUNT, SHAD_COPAY_AMOUNT, SHAD_PRIMARY_PYMT_AMOUNT, 
                         SHAD_EXCEPTION_CODE_01, SHAD_EXCEPTION_CODE_02, SHAD_EXCEPTION_CODE_03, SHAD_EXCEPTION_CODE_04, SHAD_EXCEPTION_CODE_05, MAINTENANCE_USER, MAINTENANCE_ACTIVITY, MAINTENANCE_DATE, 
                         Export_Price, Payor_Auto_Pend_Override, DIAGNOSIS_REF_09, DIAGNOSIS_REF_10, DIAGNOSIS_REF_11, DIAGNOSIS_REF_12, NDC_Code, Late_Interest
FROM            dbo.HCFA_LINE
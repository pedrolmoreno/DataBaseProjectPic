﻿

CREATE VIEW [dbo].[Claims]
AS
SELECT        CLAIM_ID, PAT_ID, VENDOR_ID, PROVIDER_ID, LOCSVC_ID, REVIEW_STATUS, CLAIM_ORIGIN, BATCH_CLAIM_ID, THIRD_PARTY_CLAIM_ID, SCAN_ID, PATIENT_ACCT_NO, PRIOR_AUTH_NUMBER, 
                         DIAG_CODE1, DIAG_CODE2, DIAG_CODE3, DIAG_CODE4, DIAG_CODE5, DIAG_CODE6, DIAG_CODE7, DIAG_CODE8, PRI_PROC_CODE, DOS, DATE_EXPORTED, DATE_FILED, DATE_POSTED, DATE_PROCESSED, 
                         DATE_RECEIVED, DATE_VOIDED, VOID_CODE, TOTAL_CHARGE, AMOUNT_APPLIED, AMOUNT_PAID, COPAY_AMOUNT, COINS_AMOUNT, DEDUCTIBLE_AMOUNT, NON_COVERED_AMOUNT, OUTSIDE_LAB, 
                         LAB_CHARGE_AMOUNT, HCFA_TYPE, SYMPTOM_TYPE, COND_RELATED_TO_1, COND_RELATED_TO_2, COND_RELATED_TO_3, ACCIDENT_STATE, ACCEPT_ASSIGNMENT, PATIENT_PAID_IND, 
                         PATIENT_PAID_ID, REFERRING_ID, REFERRING_NAME, RESUBMISSION_CODE, RESUBMISSION_DATE, Medicaid_Resubmission_Code, Medicaid_Ref_No, MAINTENANCE_USER_ORIG, 
                         MAINTENANCE_DATE_ORIG, MAINTENANCE_USER, MAINTENANCE_ACTIVITY, MAINTENANCE_DATE, DIAG_CODE9, DIAG_CODE10, DIAG_CODE11, DIAG_CODE12
FROM            dbo.HCFA_CLAIM
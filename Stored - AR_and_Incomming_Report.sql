
ALTER PROCEDURE [dbo].[usp_IncommingReport]  -- exec usp_ARInvoice '3'
	@date_start Date,
	@date_end Date
AS
BEGIN 
	SELECT
		A.DocNum,
		A.DocDueDate,
		A.CardCode,
		A.CardName,
		A.DocCurr,
		A.DocTotal,
		C.SumApplied as 'Actual_receipt',
		A.CounterRef,
		B.DocNum As 'ARVoucherNo',
		B.DocDueDate As 'ARDate',
		'Back Code',
		'GL Bank',
		'Payment Status'
	FROM 
	ORCT A
	LEFT JOIN 
	OINV B ON A.CardCode = B.CardCode AND B.U_IncomP = A.CounterRef
	LEFT JOIN 
	RCT2 C ON A.DocEntry = C.DocNum
	LEFT JOIN 
	OACT D ON B.CtlAccount = D.AcctCode
	LEFT JOIN
	DSC1 F ON F.GLAccount = D.AcctCode

	Where A.DocDueDate Between @date_start AND @date_end 
END

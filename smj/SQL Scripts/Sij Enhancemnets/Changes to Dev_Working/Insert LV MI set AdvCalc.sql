INSERT INTO ClientMIFieldSetAdvCalc
		select DISTINCT cmd.ClientMIDefinition_CLIENTGROUPCODE + SUBSTRING(c.ClientMIFieldSetAdvCalc_ClientMIFieldSetField,3, len(c.ClientMIFieldSetAdvCalc_ClientMIFieldSetField) -2), ClientMIFieldSetAdvCalc_CalculationDetails, ClientMIFieldSetAdvCalc_Inactive, GETDATE(), 'SMJ'
					 from ClientMIFieldSetAdvCalc c
					INNER JOIN ClientMIDefinition cmd
					on SUBSTRING(c.ClientMIFieldSetAdvCalc_ClientMIFieldSetField,1,2) = SUBSTRING(cmd.ClientMIDefinition_CLIENTGROUPCODE,1,2)
					WHERE c.ClientMIFieldSetAdvCalc_ClientMIFieldSetField like 'LV%'
					AND cmd.ClientMIDefinition_CLIENTGROUPCODE <> 'LV'
		
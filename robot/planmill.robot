*** Settings ***
Documentation    Planmill nettilaskutus
Resource         resource.robot


*** Variables ***
${tarkoitus}           Koti-internet-yhteys
${projekti}            Sisäiset matkat ja kulut (DP1) (73)
${yksikkokustannus}    40
${tyyppi}              7120                                   #Kotimaa - Tietoliikennekulu ALV    24%
${maksu}               Oma luottokortti

*** Test Cases ***
Initialize
    Kirjaudu planmill
    Avaa uusi kulu
    Taydenna nettikulu

Check for files
    ${index}=                   Set Variable                                                                 1
    @{files} =                  List Files
    ${max}=                     Get length                                                                   ${files}
    FOR                         ${file}                                                                      IN                       @{files}
    Log                         ${file['name']}
    Lisaa nettikulu             ${file['name']}                                                              ${file['month_name']}    ${file['start_date']}    ${file['end_date']}    ${index}    ${max}    ${file['file_path']}
    ${index}=                   Evaluate                                                                     ${index} + 1
    Exit For Loop If            ${index} > ${max}
    Scroll Element Into View    id=block.Expense_module.Expenses.Single_expense.Form.Expense_items_header
    Click Element               id=addrow1
    END

Anna kuvaus
    Input Text    id=Expense.Description    QX/2021

*** Keywords ***

Taydenna nettikulu
    Input Text                   id=Expense.Name     ${tarkoitus}
    Select From List By Label    id=PMVProject.Id    ${projekti}

Lisaa nettikulu
    [Arguments]                         ${name}                                 ${month_name}          ${start_date}    ${end_date}    ${index}    ${max}    ${file_path}
    Log                                 ${start_date}
    Input Text                          id=ExpenseItem.Start${index}            ${start_date}
    Input Text                          id=ExpenseItem.Finish${index}           ${end_date}
    Input Text                          id=ExpenseItem.UnitCost${index}         ${yksikkokustannus}
    Select From List By Value           id=ExpenseItem.TypeId${index}           ${tyyppi}
    Select From List By Label           id=ExpenseItem.PaymentTypeId${index}    ${maksu}
    Input Text                          id=ExpenseItem.Description${index}      ${month_name}
    Choose File                         id=addrow2.fileupload                   ${file_path}           
    Wait Until Page Contains Element    id=Document.Description${index}         
    Input Text                          id=Document.Description${index}         ${month_name}          

Lisaa nettiliitteet

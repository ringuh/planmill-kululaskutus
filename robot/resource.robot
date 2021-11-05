*** Settings ***
Documentation    Planmill resurssit
Library          SeleniumLibrary
Library          functions.py
Variables        secret.py



*** Variables ***
${browser}          Chrome
${addExpenseBtn}    xpath=//a[@data-tooltip="Luo uusi"]
${expenseLink}      xpath=//*[@id="nav-submenu-expenses"]


*** Keywords ***
Kirjaudu planmill
    Open Browser       ${planmill_url}    ${browser}
    Set Window Size    1920               1080

    Wait Until Page Contains Element    id=form.username    timeout=10

    Input Text                          id=form.username     ${username}
    Input Text                          id=form.password     ${password}
    Click Element                       id=sign-in-button
    Wait Until Page Contains Element    ${expenseLink}

Navigoi kulut
    Wait Until Page Contains Element    ${expenseLink}
    Click Element                       ${expenseLink}
    Wait Until Page Contains Element    ${addExpenseBtn}

Avaa uusi kulu
    Navigoi kulut
    Click Element                       ${addExpenseBtn}
    Wait Until Page Contains Element    id=block.Expense_module.Expenses.Single_expense.Form.Field_header


import pandas as pd

df = pd.read_excel("../data/prc-csp-0203-to-0607-tabs.xlsx", sheet_name = "2002-03")

for i in range(3, 25):
    if   i >= 2  and i < 7:
        sheetName = "20" + str(i).rjust(2, "0") + "-" + str(i+1).rjust(2, "0")
        
        xl = pd.read_excel("../data/prc-csp-0203-to-0607-tabs.xlsx", sheet_name = sheetName)

        df = pd.concat([df, xl], ignore_index=True)
    elif i >= 7  and i < 11:
        sheetName = "20" + str(i).rjust(2, "0") + "-" + str(i+1).rjust(2, "0")

        xl = pd.read_excel("../data/prc-csp-0708-to-1011-tabs.xlsx", sheet_name = sheetName)

        df = pd.concat([df, xl], ignore_index=True)
    elif i >= 11 and i < 15:
        sheetName = "20" + str(i).rjust(2, "0") + "-" + str(i+1).rjust(2, "0")

        xl = pd.read_excel("../data/prc-csp-1112-1415-tables.xlsx", sheet_name = sheetName)

        df = pd.concat([df, xl], ignore_index=True)
    elif i >= 15 and i < 25:
        sheetName = "20" + str(i).rjust(2, "0") + "_" + str(i+1).rjust(2, "0")

        xl = pd.read_excel("../data/prc-csp-mar16-dec24-tables-240425.xlsx", sheet_name = sheetName)

        df = pd.concat([df, xl], ignore_index=True)

df.to_csv("../data/finalLongData.csv", index=False)


from os import listdir
from os.path import isfile, join, dirname, join, abspath, normpath
import re
import calendar

internetRegex = r'internet_([0-1]\d)_(20\d\d).*'
pendingPath = join(dirname(abspath(__file__)), '..', 'pending')

months = {
    '01': 'tammikuu',
    '02': 'helmikuu',
    '03': 'maaliskuu',
    '04': 'huhtikuu',
    '05': 'toukokuu',
    '06': 'kesäkuu',
    '07': 'heinäkuu',
    '08': 'elokuu',
    '09': 'syyskuu',
    '10': 'lokakuu',
    '11': 'marraskuu',
    '12': 'joulukuu',
}


def get_internet_files():
    return [f for f in listdir(
        pendingPath) if isfile(join(pendingPath, f)) and re.match(internetRegex, f)]


def List_files():

    def createObj(filename):
        match = re.match(internetRegex, str.format(filename))
        mm = match.group(1)
        yyyy = match.group(2)
        return {
            'file_path': normpath(join(pendingPath, filename)),
            'name': filename,
            'month_name': months[match.group(1)],
            'start_date': "1.{}.{}".format(mm, yyyy),
            'end_date': "{}.{}.{}".format(
                calendar.monthrange(
                    int(yyyy),
                    int(mm)
                )[1],
                mm,
                yyyy
            )
        }

    pendingFiles = [createObj(f) for f in get_internet_files()]
    print(pendingFiles)
    return pendingFiles

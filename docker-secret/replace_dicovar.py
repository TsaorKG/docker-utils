import csv,os,string,sys,re

 

#This python script required the path of the resource's directory

#and the path to the dictionary as provided arguments

 

#---------------------------------------------------------------------------------------------------

#---------------------------------------------------------------------------------------------------

#                 GLOBAL CONSTANTE

#---------------------------------------------------------------------------------------------------

#---------------------------------------------------------------------------------------------------

 

identifier = "%%"

dicovarFilenamRegex=r'.*\.ref'

ro = re.compile(dicovarFilenamRegex)

propertyRegex='%%([\w\-]+)%%'

prop = re.compile(propertyRegex)

csv.register_dialect('equal',delimiter='=', quoting=csv.QUOTE_NONE)

 

#---------------------------------------------------------------------------------------------------

#---------------------------------------------------------------------------------------------------

#                 MAIN METHODS

#---------------------------------------------------------------------------------------------------

#---------------------------------------------------------------------------------------------------

 

#---------------------------------------------------------------------------------------------------

# Verify

#---------------------------------------------------------------------------------------------------

def verify(path, dictionary):

      if not os.path.isfile(dictionary):

            sys.exit("\033[91m" + "[ERROR]" + "\033[0m" + " : Please indicate a correct path for the csv file")

      match = convertDictionaryToList(dictionary)

      if hasDuplicateProperties(match):

            sys.exit("\033[91m" + "[ERROR]" + "\033[0m" + " : Please remove the duplicates properties")

      else:

            print("\033[94m" + "[INFO]" + " \033[0m" + " : No duplicate property")

      if not allPropertyHasValue(match):

            sys.exit("\033[91m" + "[ERROR]" + "\033[0m" + " : Please give a value to each defined property")

      else:

            print("\033[94m" + "[INFO]" + " \033[0m" + " : No missing value")

      if not allPropertyIsDefined(path,match):

            sys.exit("\033[91m" + "[ERROR]" + "\033[0m" + " : Please add the missing properties")

      else:

            print("\033[94m" + "[INFO]" + " \033[0m" + " : No missing property")

      return match

 

#---------------------------------------------------------------------------------------------------

# AllPropertyHasValue

#---------------------------------------------------------------------------------------------------

def allPropertyHasValue(listmatch):

      res = 1

      for match in listmatch:

            if match['value']=='':

                  res = 0

                  print("\033[93m" + "[WARNING]" + "\033[0m" + " : Property " + match['key'] + " has no defined value")   

      return res==1          

     

#---------------------------------------------------------------------------------------------------

# AllPropertyIsDefined

#---------------------------------------------------------------------------------------------------

def allPropertyIsDefined(path, match):

      res = 1

      properties = []

      keys = []

      if (os.path.isfile(path)|os.path.isdir(path)):

            refFiles = getRefFilesFilepath(path)

            for file in refFiles:

                  properties += getProperties(file)

            properties = list(set(properties))

      else:

            print("\033[91m" + "[ERROR]" + "\033[0m" + " : Incorrect path for the file/directory to be verified")

      for prop in properties:

            keys = getKeys(match)

            if not prop in keys:

                  print("\033[93m" + "[WARNING]" + "\033[0m" + " : Property " + prop + " is not defined in the given dictionary")

                  res = 0

      return res==1

     

#---------------------------------------------------------------------------------------------------

# HasDuplicateProperties

#---------------------------------------------------------------------------------------------------

def hasDuplicateProperties(match):

      res = None

      keys=[]

      for key in match:

            if key['key'] in keys:

                  print("\033[93m" + "[WARNING]" + "\033[0m" + " : Property "+ key['key'] + " is duplicate" )

                  res = 1

            else:

                  keys.append(key['key'])

      return res != None

 

#---------------------------------------------------------------------------------------------------

# Replace

#---------------------------------------------------------------------------------------------------

def replace(path,match):

      if os.path.isfile(path):

            if isDicovarFile(path):

                  replaceFile(path,match)

      elif os.path.isdir(path):

            recursiveReplace(path,match)

      else:

            print("\033[91m" + "[ERROR]" + "\033[0m" + " : Incorrect path for the file/directory to be replaced")

 

#---------------------------------------------------------------------------------------------------

# RecursiveReplace

#---------------------------------------------------------------------------------------------------

def recursiveReplace(path,match):

      refFiles = getRefFilesFilepath(path)

      for file in refFiles:

            replaceFile(file,match)

 

#---------------------------------------------------------------------------------------------------

# ReplaceFile

#---------------------------------------------------------------------------------------------------

def replaceFile(filepath,listmatch):

      lines = None

      with open(filepath) as f:

            lines = f.readlines()

      hasChange = False

      for i in range(len(lines)):

            for match in listmatch:

                  dicovar = identifier+match['key']+identifier

                  if dicovar in lines[i]:

                        hasChange = True

                        newdicovar = match['value']

                        lines[i] = lines[i].replace(dicovar,newdicovar)

      if hasChange:

            os.remove(filepath)

            filepath = filepath.replace('.ref','')

            print("\033[94m" + "[INFO]" + " \033[0m" + " : The file " + filepath + " has been successfully replaced")

            with open(filepath, "w") as f:

                  f.writelines(lines)

 

#---------------------------------------------------------------------------------------------------

#---------------------------------------------------------------------------------------------------

#                 UTILS

#---------------------------------------------------------------------------------------------------

#---------------------------------------------------------------------------------------------------

                 

#---------------------------------------------------------------------------------------------------

# GetKeys

#---------------------------------------------------------------------------------------------------

def getKeys(match):

      keys=[]

      for key in match:

            keys.append(key['key'])

      return keys

 

#---------------------------------------------------------------------------------------------------

# GetProperties

#---------------------------------------------------------------------------------------------------

def getProperties(filepath):

      lines = None

      cur = []

      with open(filepath) as f:

            lines = f.readlines()

      for i in range(len(lines)):

            cur += re.findall(prop, lines[i])

      return cur

 

#---------------------------------------------------------------------------------------------------

# ConvertDictionaryToList

#---------------------------------------------------------------------------------------------------

def convertDictionaryToList(csvFilePath):

      csvlist = []

      with open(csvFilePath) as csvfile:

            reader = csv.DictReader(csvfile , fieldnames=['key','value'], dialect='equal')

            csvlist = list(reader)

      return csvlist

 

#---------------------------------------------------------------------------------------------------

# GetRefFilesFilePath

#---------------------------------------------------------------------------------------------------

def getRefFilesFilepath (path):

      refFiles = []

      for root, subdirs, files in os.walk(path):

            for name in files:

                  filePath = os.path.join(root, name)

                  if isDicovarFile(filePath):

                        refFiles.append(filePath)

      return refFiles

     

#---------------------------------------------------------------------------------------------------

# IsDiscovarFile

#---------------------------------------------------------------------------------------------------    

def isDicovarFile(filepath):

      mo = ro.match(filepath)

      return mo != None      

 

#---------------------------------------------------------------------------------------------------

# GetAllEnvProp

#---------------------------------------------------------------------------------------------------    

def getAllEnvProp(dictionary):

      with open(dictionary,'a') as file:

            for key in os.environ:

                  file.writelines("\n"+key+"="+os.environ.get(key))

 

#---------------------------------------------------------------------------------------------------

# ExportDictionaryAsEnv

#---------------------------------------------------------------------------------------------------    

def exportDictionaryAsEnv(listProp):

      for prop in listProp:

            os.environ[prop['key']]=prop['value']

            print(os.environ[prop['key']])

           

#---------------------------------------------------------------------------------------------------

# ExportDictionaryAsEnvTest

#---------------------------------------------------------------------------------------------------    

def exportDictionaryAsEnvTest():

      os.environ["TEST"]="TEST"

      print(os.environ["TEST"])

#---------------------------------------------------------------------------------------------------

#---------------------------------------------------------------------------------------------------

#                 MAIN

#---------------------------------------------------------------------------------------------------

#---------------------------------------------------------------------------------------------------

def main():

      pathToBeReplaced = sys.argv[1]

      dictionary = sys.argv[2]

      getAllEnvProp(dictionary)

      print("\033[94m" + "[INFO]" + " \033[0m" + "    ---[ Starting verification ]---")

      match = verify(pathToBeReplaced,dictionary )

      print("\033[94m" + "[INFO]" + " \033[0m" + "    ---[  End of verification  ]---")

      print("\033[94m" + "[INFO]" + " \033[0m" + "    ---[ Starting replacement  ]---")

      replace(pathToBeReplaced, match)

      print("\033[94m" + "[INFO]" + " \033[0m" + "    ---[  End of replacement   ]---")

     

#---------------------------------------------------------------------------------------------------

#---------------------------------------------------------------------------------------------------

#                 EXECUTE

#---------------------------------------------------------------------------------------------------

#---------------------------------------------------------------------------------------------------

 

 

main()

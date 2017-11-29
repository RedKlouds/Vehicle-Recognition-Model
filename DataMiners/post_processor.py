import re,csv,os,sys, glob
#sys.path.append(0,'/datafiles')


def get_data_files():
    #list only .csv
    x = glob.glob('*.csv')
    #x = os.listdir('C:\\Users\\MugenKlaus\\Desktop\\santitaziaiton test\\datafiles')
    #x = os.listdir()
    #x = ['ACURA_specs_data.csv']
    return x
    
def start():
    #check to see if a directory for storing our cleaned files exists
    if not os.path.exists('pre_processed_files'):
        os.makedirs('pre_processed_files')
    
    file_list = get_data_files()

    #prefix = "C:\\Users\\MugenKlaus\\Desktop\\santitaziaiton test\\datafiles"

    for file in file_list:
        print('working on ... %s' % file)
        name = file.split('_')[0]
        #newfileName = "%s\\cleaned_%s.csv" % (prefix,name)

        #this is the file for creating the new post-processed file
        newFileName = "pre_processed_files/cleaned_%s.csv" % name

        newf = open(newFileName,'w',newline='')
        number_of_bad_data_rows = 0

        #file_ = "%s\\%s" %(prefix,file)
        #this is the file for reading the data
        file_ = "%s" % file
        with open(file_,newline='') as f:
            reader = csv.reader(f)
            writer = csv.writer(newf)
            header = writer.writerow(reader.__next__())
            for row in reader:
                row_d = row
                #check the row
                err, data = s(row_d)
                #if no error write to the new file
                if not err:
                    
                    writer.writerow(data)
                else:
                    number_of_bad_data_rows+=1
        print("number of bad rows %s " % number_of_bad_data_rows)
        newf.close()
        
def s(data_list):

    #need to check wether there is garbage data
    error = False
    x = list()
    try:
        Model = data_list[0]
        fuelType = data_list[1]
        bhp_ = re.compile('(?<=or) (\d+\.\d*|\d+) (?=bhp)')
        #'or(\d+\.\d*|\d+)bhp'
        #bhp
        bhp_d = bhp_.findall(data_list[2])[0].replace(' ','')

        #lb.ft
        trq_ = re.compile('or (\d+\.\d*|\d+) lb.ft')
        trq_d = trq_.findall(data_list[3])[0].replace(' ','')

        #gallons tank US gallons
        gal_ = re.compile('gallons (\d+\.\d*|\d+) US')
        gal_d = gal_.findall(data_list[4])[0].replace(' ','')

        #curb weight in lbs
        curbW_ = re.compile('OR(\d+\.\d*|\d+) lbs')
        curbW_d = curbW_.findall(data_list[5])[0].replace(' ','')
        if curbW_d =="0":
            #if curb weight is zero then raise exception
            #and flag for error data
            print('rasing exception')
            raise Exception("curb weight cannot be zero")
        #top speed in MPH
        topS_ = re.compile('or (\d+\.\d*|\d+) Mph')
        topS_d = topS_.findall(data_list[6])[0].replace(' ','')

        #length INCHES
        leth_ = re.compile('or (\d+\.\d*|\d+) inches')
        leth_d = leth_.findall(data_list[7])[0].replace(' ','')

        #width INCHES
        wid_ = re.compile('cmor (\d+\.\d*|\d+) inches')
        wid_d = wid_.findall(data_list[8])[0].replace(' ','')

        #height INCHES
        height_ = re.compile('cmor (\d+\.\d*|\d+) inches')
        height_d = height_.findall(data_list[9])[0].replace(' ','')

        x.append(Model)
        x.append(fuelType)
        x.append(bhp_d)
        x.append(trq_d)
        x.append(gal_d)
        x.append(curbW_d)
        x.append(topS_d)
        x.append(leth_d)
        x.append(wid_d)
        x.append(height_d) 
        x.append(data_list[10])
        #print(x)
    except Exception as e:
        error = True
        print(e, data_list)
        pass
            
    #return an error flag if there was bad data, so the caller can check this flag
    #and skip writing to the file if an error occurs
    return error, x

start()

from bs4 import BeautifulSoup
import requests, csv, re, threading


#header fields
############
#Configurations:
#   ->if we want more fields to scrape just add the EXACT text plus a white space in front
#
#fieldnames = [
#    'Engine Type ', 'Fuel type ', 'Fuel System ', 'Engine Position ',\
#    'Engine size - Displacement - Engine capacity ',\
#    'Maximum power - Output - Horsepower','Maximum torque ',\
#    'Fuel Consumption(combined) ','Top Speed ',\
#    'Length ','Width ','Height ','Num. of Seats ',\
#    'Engine type - Number of cylinders '
#    ]
#
#####################
fieldnames = [
    'Model',\
    'Fuel type ',\
    'Maximum power - Output - Horsepower ','Maximum torque ',\
    'Fuel Tank Capacity ', 'Curb Weight ','Top Speed ',\
    'Length ','Width ','Height ',\
	'Drive wheels - Traction - Drivetrain '\

    ]
#this program current skips the first row of data

def init_file_header(file_name):
    #header fields
    f = open(file_name,'w', newline='')
    writer = csv.DictWriter(f,fieldnames=fieldnames)
    writer.writeheader()
    f.close()

def cleanString(string):
    remove = ['\n','\t']
    for char in remove:
        string = string.replace(char,'')
    return string


def print_to_file(file_name,data_to_write):
    f = open(file_name, 'a+', newline='')
    writer = csv.DictWriter(f, fieldnames = fieldnames)
    writer.writerow(data_to_write)
    f.close()

def make_dictionary(list_of_specs):
    #populate a dicitonary
    temp_dict = dict()
    for i in range(len(fieldnames)):
        temp_dict[fieldnames[i]] = list_of_specs[i]
    return temp_dict


        
def _getDataHelper(data):
    
    clean_string = cleanString(data.find_all('td')[1].text)
    
    return clean_string
        
def get_all_links(car_model):
    domain = "https://www.ultimatespecs.com"
    url = "%s/car-specs/%s" % (domain, car_model)
    result_list = list()
    r = requests.get(url)
    soup = BeautifulSoup(r.text,'html5lib')

    table_d = soup.find('div',{'style':'/*height: 1900px; overflow-y: auto; */'})
    col_data = table_d.find_all('td',{'valign':'top'})

    #find each table cahr

    for column in col_data:
        links = column.find_all('tr')
        for i in range(len(links) -1):
            link = links[i].a
            #print("%s LINK: %s" % (link.text,link['href']))
            #this will store a link directly to the url of the file
            #lets store url links in a list
            html_url = "%s%s" % (domain, link['href'])
            result_list.append(html_url)

            
    return result_list

def clean(st):
    l = ['\n','\t']
    for c in l:
        st = st.replace(c,'')
    return st

def scrape_specs_(url,model):
    #Given a full URL path to a html page scape the data from the page and
    #return a dictionary contrainig the various elements
    

    return_list = list()
    
    p = re.compile(':(.*)')
    q = re.compile('(.*):')
    r = requests.get(url)
    s = BeautifulSoup(r.text,'html5lib')

    d = s.find('div',{'class':'ficha_specs_main'} )
    tr_data = d.find_all('tr')
    #look into seeing wether the item exist in our header

    ret_dict = dict()
    
    for i in tr_data:
        temp_s = clean(i.text)
        #now check if the beginning of the string is in our header
        m = q.findall(temp_s)
        if len(m) > 0:
            m = m[0]
            if m in fieldnames:
                v = p.findall(temp_s)[0]
                #return_list.append(v)
                ret_dict[m] = v

    ret_dict['Model'] = model    
    return ret_dict
                
                
                       





def prompt_cool_down():
    import time
    print('[*] Thanks for using RedKlouds data Scrapper..')
    
    print('[*] System cooling down, 5 seconds auto exit')
    for i in range(5,0,-1):
        time.sleep(1)
        print('[*] Cool down %s' %i)
    print('bye')

def programStart(model_list):

    for car in model_list:
        print('[+] Gathering all  model spec Links for %s...' % car)
        link_data = get_all_links(car)
        
        #set up the headers for the csv file
        print('[+] Creating the csv file...')
        f_name = "%s_specs_data.csv" % car
        init_file_header(f_name)
        #for each link in the list above scrap the data
        print('[+] Starting scraping data for each %s link(s)' % len(link_data))
        for each_link in link_data:
                #scrape the current html page, return a dictionary
                specs_dictionary = scrape_specs_(each_link)
                #specs_list = scrape_specs(each_link)
                #into a dictionary
                
                #refined_dict = make_dictionary(specs_list)
                #and write the dictionary to a file
                print_to_file(f_name, specs_dictionary)
        print('[+] Finished scraping for model %s ' % car)
    print('[+] Data scraping has successfully finished you files named:')
    for i in model_list:
        print("%s_specs_data.csv" % i)
        #have a list of EXACT headers as the ones here
        #get the data and check if something from the list is also in this item
        #ex [engine code, fuelt type] data in header if so
        #   get a reg ex to add a dictionary withy the current header, and everything after the ':' sign
        
#programStart(['TESLA','FORD'])
def run_scrape(car_model):
    print('[+] Gathering all  model spec Links for %s...' % car_model)
    link_data = get_all_links(car_model)
    
    #set up the headers for the csv file
    print('[+] Creating the csv file...')
    f_name = "%s_specs_data.csv" % car_model.upper()
    init_file_header(f_name)
    #for each link in the list above scrap the data
    #counter = 0
    print('[+][%s] Starting scraping data for each %s link(s)' % (car_model.upper(),len(link_data)))
    for each_link in link_data:
            #scrape the current html page, return a dictionary
            specs_dictionary = scrape_specs_(each_link, car_model.upper())
            #specs_list = scrape_specs(each_link)
            #into a dictionary
            #print("iteration %s" % counter)
            #refined_dict = make_dictionary(specs_list)
            #and write the dictionary to a file
            print_to_file(f_name, specs_dictionary)
            #counter +=1
    print('[+] Finished scraping for model %s ' % car_model)
    print('[+] Your files name is : %s' % f_name)


def run_threaded(func_job):
    thread_job = threading.Thread(target=func_job)
    thread_job.start()

def main(data):

    
    jobs = []
    for i in data:
        thread = threading.Thread(target=run_scrape,args=(i,))
        jobs.append(thread)
    for job in jobs:
        job.start()

    for job in jobs:
        job.join()
li = ['Acura', 'Alfa', 'Romeo', 'Aston', 'Martin', 'Audi', 'Bentley', 'BMW', 'Cadillac',\
      'Chevrolet', 'Chrysler', 'Citroen', 'Dacia', 'Dodge', 'Ferrari', 'Fiat', 'Ford', \
      'Honda', 'Hyundai', 'Jaguar', 'Jeep', 'Kia', 'Lamborghini', 'Lancia', 'Land', 'Rover', \
      'Lexus', 'Maserati', 'Mazda', 'McLaren', 'Mercedes', 'Benz', 'Mini', 'Mitsubishi',\
      'Nissan', 'Opel', 'Peugeot', 'Porsche', 'Renault', 'Rolls', 'Royce', 'Rover', 'Saab', \
      'Seat', 'Skoda', 'Smart', 'Subaru', 'Tesla', 'Toyota', 'Vauxhall', 'Volkswagen', 'Volvo']

main(li)

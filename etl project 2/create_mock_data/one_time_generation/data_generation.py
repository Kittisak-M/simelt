from faker import Faker
import random
import pandas as pd

# branch table
# set = 20 branches
fake = Faker()

# Thai cities to random
thai_cities = [
    'Bangkok', 'Chiang Mai', 'Phuket', 'Khon Kaen', 'Nakhon Ratchasima',
    'Ayutthaya', 'Nakhon Si Thammarat', 'Udon Thani', 'Hua Hin', 'Pattaya',
    'Sukhothai', 'Surat Thani', 'Ubon Ratchathani', 'Mae Hong Son', 'Lampang',
    'Ratchaburi', 'Nakhon Pathom', 'Songkhla', 'Loei', 'Trat', 'Chonburi',
    'Samut Prakan', 'Nonthaburi', 'Pathum Thani', 'Prachuap Khiri Khan', 'Phetchaburi',
    'Nakhon Nayok', 'Uttaradit', 'Kamphaeng Phet', 'Yasothon', 'Amnat Charoen',
    'Roi Et', 'Kalasin', 'Mukdahan', 'Sakon Nakhon', 'Saraburi',
    'Suphan Buri', 'Lopburi', 'Nakhon Phanom', 'Chaiyaphum', 'Buriram'
]

def generate_fake_branch_data(num_records):
    branch_data = []
    for _ in range(num_records):
        branch = {
            'branch_type': random.choice(['standalone', 'in_shopping_mall', 'in_community_mall', 'small_shop']),
            'city': random.choice(thai_cities),  # Random cities from list
            'country': 'Thailand',
            'phone_number': fake.phone_number(),
            'created_date': fake.date_this_decade()
        }
        branch_data.append(branch)
    return branch_data

branches = generate_fake_branch_data(20) # number of records
branches_df = pd.DataFrame(branches)

# customers_table
# set 1000 customers

def generate_fake_customers_data(num_records):
    customer_data = []
    
    for _ in range(num_records):
        customer = {
            'first_name': fake.first_name(),
            'last_name': fake.last_name(),
            'email': fake.email(),
            'phone': fake.phone_number(),
            'address': fake.address(),
            'city': fake.city(),
            'country': fake.country(),
            'registration_date': fake.date_this_decade()
        }
        customer_data.append(customer)
    
    return customer_data

customers = generate_fake_customers_data(1000)
customers_df = pd.DataFrame(customers)

# customers_table
# set = 100 employees
def generate_employees_data(num_records=50):
    employees_data = []
    
    for _ in range(num_records):
        employee = {
            'first_name': fake.first_name(),
            'last_name': fake.last_name(),
            'position': random.choice(['Manager', 'Sales Associate', 'Cashier', 'Stock Clerk', 'Supervisor']),
            'branch_id': random.randint(1, 20),  # 20 branches
            'salary': round(random.uniform(30000, 90000), 2),
            'hire_date': fake.date_this_decade(),
            'termination_date': fake.date_between(start_date='-1y', end_date='today') if random.choice([True, False]) else None,
            'email': fake.email(),
            'phone': fake.phone_number(),
            'is_active': random.choice([0, 1])
        }
        employees_data.append(employee)
    
    return employees_data

employees = generate_employees_data(100)

employees_df = pd.DataFrame(employees)

# inventory table
def create_inventory_data(num_branches, num_products):
    data = {
        'product_id': [],
        'branch_id': [],
        'quantity': [],
        'last_updated': []
    }

    for branch in range(1, num_branches + 1):
        for product in range(1, num_products + 1):
            data['product_id'].append(product)
            data['branch_id'].append(branch)
            data['quantity'].append(random.randint(0, 1000))  
            data['last_updated'].append(fake.date_this_year()) 

    return pd.DataFrame(data)

inventory_df = create_inventory_data(20, 66)

# suppliers 20
def generate_fake_supplier_data(num_records):
    supplier_data = []
    
    for _ in range(num_records):
        supplier = {
            'supplier_name': fake.company(),
            'contact_name': fake.name(),
            'contact_email': fake.email(),
            'contact_phone': fake.phone_number(),
            'address': fake.address(),
            'city': fake.city(),
            'country': fake.country()
        }
        supplier_data.append(supplier)
    
    return supplier_data

suppliers = generate_fake_supplier_data(20)
suppliers_df = pd.DataFrame(suppliers)
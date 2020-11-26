install.packages("dplyr")

library(dplyr)
data = read.csv("C:\\Users\\watch\\Desktop\\R Programming for Data Science Training\\Customer_Churn-1.csv")
View(data)


#1.	Extract these individual columns:
# a.	Extract the 5th column & store it in 'customer_5'
select(data,5) -> customer_5

View(customer_5)

#or we can use the column name
select(data,"Dependents") -> cust_5

View(cust_5)

# b.Extract the 15th column & store it in 'customer_15'

select(data,15) -> customer_15

View(customer_15)

#extra question

#extract gender column from your customer churn data set using column names
select(data,"gender")-> genders

View(genders)

#extra  question and example
select(data,"gender",5,8,"tenure")-> mixed
View(mixed)

#2.Extract the column numbers 3,6,9,12,15 & 18 and store the result in 'customer_3_multiple'
select(data,3,6,9,12,15,18) -> customer_3_multiple

View(customer_3_multiple)


#3.Extract all the columns from column number-10 to column number-20 and store the result in 'c_10_20'

select(data,10:20) -> c_10_20

View(c_10_20)

#4. Extract all the columns which start with letter 'P' & store it in 'customer_P'

select(starts_with("P")) -> customer_P
View(customer_P)

#5.	Extract all the columns which end with letter 's' & store it in 'customer_s'

select(ends_with("s")) -> customer_s

View(customer_s)


#filter()

#1.	Customers whose Internet Service is "DSL"

filter(data, InternetService=="DSL") -> customer_dsl
View(customer_dsl)

#2.	Extract all the customers whose Contract type is 'Month-to-month' & store the result in 'customer_month'

#create table to cross check
table(data$Contract)

filter(data,Contract=="Month-to-month") -> customer_month
View(customer_month)

#3.	Extract all the male senior citizens whose Payment Method is Electronic check 
#& store the result in 'senior_male_electronic'

#create table to cross check
table(data$gender,data$SeniorCitizen,data$PaymentMethod)

filter(data, gender=="Male" & SeniorCitizen==1 & PaymentMethod=="Electronic check") -> senior_male_electronic
View(senior_male_electronic)

#4.	All those customers whose tenure is greater than 70 months or their Total charges is more than 8000$

filter(data, tenure>70 | TotalCharges>8000) -> customer_total_tenure

View( customer_total_tenure)

#5.	Extract all the customers whose Contract is of two years, payment method is Mailed check & the value 
# of Churn is 'Yes' & store the result in 'two_mail_yes'

filter(data, Contract=="Two year" & PaymentMethod=="Mailed check" & Churn =="Yes") -> two_mail_yes

View(two_mail_yes)


#Questions on sample_n(), sample_frac() & count():

#1.	Extract 333 random records from the customer_churn dataframe & store the result in 'customer_333'

sample_n(data,333) -> customer_333

View(customer_333)

set.seed(data,2)

#set.seed will freeze the random values
#syntax:set.seed(any number)

#2.	Extract 1000 random records from the customer_churn dataframe & store the result in 'customer_1000'


sample_n(data,1000) -> customer_1000

View(customer_1000)


#3.	Randomly extract 23% of the records from the customer_churn dataframe &
#store the result in 'customer_23_percent'

sample_frac(data,.23) -> customer_23_percent

View(customer_23_percent)

#50% 
sample_frac(data,.50) -> customer_50_percent

View(customer_50_percent)

#4.	Get the count of different levels from the 'PaymentMethod' column

count(data,PaymentMethod) 

#base function
table(data$PaymentMethod)

#5.	Get the count of different levels from the 'Churn' column

count(data,Churn)

#base function
table(data$Churn)

#Questions on summarise() & group_by():

#1.	Get the median, variance & standard deviation for the 'tenure' column

summarise(data,median(tenure),var(tenure),sd(tenure))

#2.	Get the median, variance & standard deviation for the 'MonthlyCharges' column
summarise(data,median(MonthlyCharges),var(MonthlyCharges),sd(MonthlyCharges))

#3.	Get the standard deviation of 'tenure' & group it w.r.t 'PaymentMethod' column

summarise(group_by(data,PaymentMethod),sd(tenure))

#4.	Get the median of 'MonthlyCharges' & group it w.r.t 'Contract' column



summarise(group_by(data,Contract),median(MonthlyCharges))

#5.	Get the variance of 'TotalCharges' & group it w.r.t 'InternetService' column

table(is.na(data))
colSums(is.na(data))
na.omit(data) -> data

summarise(group_by(data,InternetService),var(TotalCharges))
#or

data %>% group_by(InternetService) %>% summarise(var(TotalCharges))
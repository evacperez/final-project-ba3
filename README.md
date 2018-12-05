#Final Project, Team BA3
	
	Eva Perez
	Jeff Zhang
	Joselly Anne Ongoco
	Phuong Le
	
	
Professor Ott Toomet
INFO 201
04 December, 2018


## Project Summary
Our project is to analyze the “Human Development Data (1990-2017)” from the United Nations Development Programme linked to the World Bank Dataset. Starting in 1990, the United Nations Human development program collects data on multiple aspects regarding its member countries. The data includes a country’s level of inequality, education level, healthcare, and income level to track a countries progress in development.  The data can be found [here](http://hdr.undp.org/en/data). 

We have chosen to study education and analyze the three subcategories: 


1. expected years of schooling (years) 
2. expected years of schooling, female (years) 
3. expected years of schooling, male (years)


Within these chosen subcategories the data includes variables for:


1. HDI Rank (Human Development Index)*
2. Country
3. A Column of data for each Year (X1990 - X2017)


*The HDI Rank, gives countries an index based on life expectancy, education, and per capita income indicators, which rank countries into four tiers of human development.


Our target audience is economists devoted to education: people interested in demographics within the educational system throughout the nation. More often, these are individuals who are social scientists studying the relationship between human behavior and the levels of development in various countries across the world. Our project allows users to answer the following questions:

**How does each continent rank when comparing expected years of schooling rates? **

**How do male and female expected years of schooling rates compare over the years for individual countries with data available?**

**When using the UN’s categorization of developed and developing nations, do developing nations have a lower expected years of schooling rate compared to developed nations, and if so, by how much of a gap?**


Our main page looks as follows:


![Main Screen](../mainpage.png)


We created a multipage shiny app, where each tab has a purpose in our overall application.


In the first tab we visually introduce our topic of worldwide education. In the second tab we introduce our team that created the application. In the third tab we officially introduce our problem in writing, as well as the questions we aim to answer, and the purpose of each following tab. 


Our fourth tab introduces our first question, _How does each continent rank when comparing expected years of schooling rates?_ We visually answer this with a select box and drop down widget, where the user can select each continent and what year of the data they want to see (1990-2017). We did not include Antarctica because there was no data for the continent. We display the chosen data with a map plot that has a range of colors relating to the rate of expected schooling. The user also has the option to view the rates in a bar chart format.


Our fifth tab introduces our second question, _How do male and female expected years of schooling rates compare over the years for individual countries with data available?_ Our visualization for this question is a scatterplot that shows the rates of schooling over the collected years. The user has the choice of choosing which country to look at, and whether they want data for just females, just males, or data for both.


Our sixth tab introduces our third question, _When using the UN’s categorization of developed and developing nations, do developing nations have a lower expected years of schooling rate compared to developed nations, and if so, by how much of a gap?_ The UN's categorization can be found [here](https://unstats.un.org/unsd/methodology/m49/). This visualization displays a barchart where the user can choose between Developed and Developing countries and which year of data they prefer to see. The data displayed shows each country in the correct categorization and their comparing expected years of schooling rate for the selected year.


Our seventh tab include links to charities and other organization with aim in creating equity in education systems worldwide.Our goal is for people to recognize the patterns and feeling emotionally charged to take action in get involved in creating education systems that benefit all children.


Public repository on GitHub: https://github.com/evagj/final-project-ba3

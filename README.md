# Final Project, Team BA3
	Eva Perez
	Jeff Zhang
	Joselly Anne Ongoco
	Phuong Le
Professor Ott Toomet
INFO 201
15 November, 2018

## Project Proposal
Our team, group BA3, will be working with the “Human Development Data (1990-2017)” from the United Nations Development Programme linked to the World Bank Dataset. Starting from 1990, the United Nations Human development program collects data on multiple aspects regarding its member countries. The data includes a country’s level of inequality, education level, healthcare, and income level to track a countries progress in development.  The data can be found at http://hdr.undp.org/en/data and this project will be based on CSV files generated from there. We have chosen to study Education and analyze the three subcategories: 1. expected years of schooling (years), 2. expected years of schooling, female (years), 3. expected years of schooling, male (years). The target audience would be economists devoted to education: people interested in demographics within the educational system throughout the nation. More often, these are individuals who are social scientists studying the relationship between human behavior and the levels of development in various countries across the world. Our team project will answer the following questions for our honed audience:

**Do Western nations have a higher or lower expected years of schooling rate compared to Eastern nations?**

**How do male and female expected years of schooling rates compare over the years for individual countries with data available?**

**When using the UN’s categorization of developed and developing nations, do developing nations have a lower expected years of schooling rate compared to developed nations, and if so, by how much of a gap?**

Our final format will be Shiny app. We feel that the idea of having a more interactive visualization of our data will increase attentiveness and awareness to the content. We are going to use .csv to read our data and turn it into a dataframe that we can manipulate further to answer our set questions. In wrangling with data, additional calculations will be added to the data set, such as the gender difference in the years of schooling for each country. Additional tables will also be created for the purpose of providing summaries, such as the difference between the genders by development status and the difference in total expected years of schooling between those who are developed and those who are developing. Major libraries that will be utilized in the project are dplyr, ggplot2, maps and shiny. All of the questions posed will be answered by statistical analysis that will involve a wide range of calculations to answer the necessary questions: the mean, median, mode, standard deviations, and percentiles. One major challenge we anticipate is that there are some gaps in data for a few countries, or some data for certain years are missing (eg. data and year for countries are often staggered), therefore, it will be important to combine recent years in a fashion that reflects a global trend to answer our three main questions posed by this proposal. 

Public repository on GitHub: https://github.com/evagj/final-project-ba3

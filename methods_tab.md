---
title: "Methods"
#author: "Kassandra Franco"
#date: "5/28/2018"
output: html_document
---

#Survey Development and Design

![Sign on Rainier Vista](survey-sign-1.jpg)

Our survey starts out with the picture above, and asks survey takers what the first word that
comes to mind is upon seeing it. This is meant to gauge people's first reactions to the signs,
and to show this we created a word cloud. Two sections follow: Demographics and Resilience Lab Signs.

The demographics section is meant to gauge the demographics of our sample, and to determine the
possible need for weights. We ask about gender, ethnicity, age, year in school, major/intended major,
minor, own rating of mental health, experience regarding microaggressions and microcompassions
relative to peers, and whether or not they browse UW's main Facebook meme page: UW Teens for Boundless
Memes. This section ends by asking if the survey taker has seen the Resilience Lab signs, and
if they answer no, the survey closes as the rest of the questions are not applicable to these people.

The Resilience Lab Signs section is meant to further understand the survey taker's perceptions of, 
reactions to, and behavioral change from the signs. Here, we ask about where the people first saw 
the signs, whether or not they followed the website provided (resilience.uw.edu) on the signs, 
whether or not their feelings changed and how, how uplifted or discouraged they felt, if their 
behavior changed and how, if they've talked to others about the signs and what they talked about, and
finally, how they rate the effectiveness of the signs in terms of promoting microcompassions on campus.

Both sections are important as we used them to draw relationships among different factors within 
each of the sections (ethnicity versus mental health, rating of mental health versus experience with 
microaggressions, feelings of being uplifted versus rating of signs' effectiveness at promoting
microcompassions) but also among different factors between the two (major versus rating of signs' 
effectiveness at promoting microcompassions, rating of mental health versus feelings of being
uplifted).

# Population and Sample Demographics

The population of interest is the UW student community, as they are the main target of the 
Resilience Lab signs. In terms of keeping our sample representative of the UW student population,
we care most about two main demographical dimensions: ethnicity and major. The following table show 
UW's ethnicity makeup and our survey takers' ethnicity makeup.


```
## Error in file(filename, "r", encoding = encoding): cannot open the connection
```

```
## Error: This function should not be called directly
```

```
## Error in tbl_vars(y): object 'grouped_survey_ethnic_makeup' not found
```

```
## Error in merged_ethnicities[is.na(merged_ethnicities)] <- 0: object 'merged_ethnicities' not found
```

```
## Error in colnames(merged_ethnicities) <- c("ethnicity", "UW", "Survey"): object 'merged_ethnicities' not found
```

```
## Error in gather(merged_ethnicities, "group", "percentage.makeup", 2:3): object 'merged_ethnicities' not found
```

```
## Error in ggplot(merged_ethnicities, aes(x = ethnicity, y = percentage.makeup, : object 'merged_ethnicities' not found
```

```
## Error in eval(expr, envir, enclos): object 'ethnicity_plot' not found
```

Ethnicity-wise, our survey takers are not very representative of the UW population. For one, our sample consists of ~60% Asians, when the UW population is only ~25% Asian. Caucasians also only make up ~25% of our sample, when they make up ~40% OF THE UW population. Another discrepancy is that Native Americans and Latinos are not represented in our sample. We also have no students in the International category, however that is because we did not include an International option in our survey. Source: [OMAD 2017-2018 Fact Sheet](https://www.washington.edu/omad/files/2017/10/2017-18_OMAD_FACTSHEET_final_10-17-17.pdf)


```
## Error: This function should not be called directly
```



|major                            |count |
|:--------------------------------|:-----|
|Psychology                       |944   |
|Computer Science and Engineering |814   |
|Communication                    |760   |
|Biochemistry                     |661   |
|Economics                        |646   |

```
## Error in knitr::kable(survey_top_majors, caption = "Top 5 Survey Sample Majors"): object 'survey_top_majors' not found
```

Major-wise, we have a disproportionate amount of Informatics students and Electrical Engineering students, which makes a lot of sense because we advertised our survey a lot in our INFO 498 class, and also because one of our project members, Elisa, has a lot of Electrical Enginnering friends. Source: [UW Office of the Registrar: Quick Stats](https://studentdata.washington.edu/wp-content/uploads/sites/3/2018/04/Quick_Stats_Seattle_Spr2018.pdf)

# Limitations

Discrepancies and inaccuracy can arise from the misrepresentation of certain demographic groups in our survey. We had considered using survey weights for either ethnicity or major, however decided against it because of the fact that we did not initially stratify our survey. That being said, we are keeping aware of these discrepancies. 


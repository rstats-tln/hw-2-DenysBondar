---
title: "Homework 2: ggplot"
date: "2019-03-10"
author:"Denys Bondar"
output: github_document: default
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

```{r}
library(tidyverse)
```


- Take the first faceted plot in this section:

```{r}
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)
```

What are the advantages to using faceting instead of the colour aesthetic? What are the disadvantages? How might the balance change if you had a larger dataset?
Facetting helps when you want to distinguish only particular facets  while application of the color aesthetic is better to show acute locations of points . Color shows the relationship in general while facetting is used to show relationship within groups.
- Recreate the R code necessary to generate the following graphs.

```{r, out.width=200}
knitr::include_graphics(paste0("plots/fig", 1:6, ".png"))
```
```{r}
# 1st.
ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  geom_smooth(se = F)
ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  geom_smooth(aes(group = drv), se = F)
```
# 2nd.
```{r}
ggplot(mpg, aes(displ, hwy, colour = drv)) +
  geom_smooth(se = F) +
  geom_point()
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(colour = drv)) +
  geom_smooth(se = F)
```
# 3rd.
```{r}
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(colour = drv)) +
  geom_smooth(aes(linetype = drv), se = F)
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(colour = drv,se = F)) 
```

- Most geoms and stats come in pairs that are almost always used in concert. Read through the documentation and make a list of all the pairs. What do they have in common?

They tend to have their names in common, `stat_smooth()` and `geom_smooth()`.
However, this is not always the case, with `geom_bar()` and `stat_count()` and `geom_histogram()` and `geom_bin()` as notable counter-examples.
Also, the pairs of geoms and stats that are used in concert almost always have each other as the default stat (for a geom) or geom (for a stat).
- Compare and contrast geom_jitter() with geom_count().
```{r}
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_jitter()
```

```{r}
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_count()
```
- What does the plot below tell you about the relationship between city and highway mpg (fuel consumption)? Why is coord_fixed() important? What does geom_abline() do?

```{r}
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_point() + 
  geom_abline() +
  coord_fixed()
```

The relationships is approximately linear, though overall cars have slightly better highway mileage than city mileage. But using coord_fixed(), the plot draws equal intervals on the x and y axes so they are directly comparable. geom_abline() draws a line that, by default, has an intercept of 0 and slope of 1. This aids us in our discovery that automobile gas efficiency is on average slightly higher for highways than city driving, though the slope of the relationship is still roughly 1-to-1.

- What is the default geom associated with stat_summary()?
The default geom is geom_pointrange()

```{r}
ggplot(data = diamonds) + 
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.ymin = min,
    fun.ymax = max,
    fun.y = median)
```

How could you rewrite the previous plot to use that geom function instead of the stat function?
```{r}
ggplot(data = diamonds) + 
  geom_pointrange(mapping = aes(x = cut, y = depth),
                  stat = "summary",
                  fun.ymin = min,
                  fun.ymax = max,
                  fun.y = median)
```
  ```
- What does geom_col() do? How is it different to geom_bar()?
geom_bar() uses the stat_count() statistical transformation to draw the bar graph. geom_col() assumes the values have already been transformed to the appropriate values. geom_bar(stat = "identity") and  geom_col() are equivalent.
- What variables does stat_smooth() compute? What parameters control its behaviour?
stat_smooth() calculates four variables:

y - predicted value
ymin - lower pointwise confidence interval around the mean
ymax - upper pointwise confidence interval around the mean
se - standard error
- In our proportion bar chart, we need to set group = 1. Why? In other words what is the problem with these two graphs?
```
```{r}
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = ..prop..))
```
```{r}
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = color, y = ..prop..))
```
If we forget to set group = 1, the proportions for each cut are computed using the complete dataset, rather than each subset of cut. Otherwise graphs to look like this:

```{r}
ggplot(data = diamonds) + 
geom_bar(mapping = aes(x = cut, y = ..prop..,group = 1))
```
```{r}
ggplot(data = diamonds) + 
geom_bar(mapping = aes(x = cut, fill = color, y = ..prop..,group = 1))
```
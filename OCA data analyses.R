#Loading libraries
library(readxl)
library(dplyr)
library(rio)
library(openxlsx)
library(tidyverse)
library(openxlsx)
library(hablar)
library(plyr)
library(tidyr)



####Merging individual Brand files####
##C&A##

Farmer_details <- read_excel("SmartFarming/OCA/2017-2018/2017-2018/01. C&A/01. Cropin default download/Farmer_Details.xlsx")

Harvest_details <- read_excel("SmartFarming/OCA/2017-2018/2017-2018/01. C&A/01. Cropin default download/Harvest_Details.xlsx")
str(Harvest_details)
#Harvest_details <- Harvest_details %>% 
#select(farmercode, village, plotname, crop, variety,`sowing_area(Acres)`,HPAR, FEHD, HPWR, HRS, per_area_yield,harvest_quantity) %>% 
#distinct(farmercode,.keep_all=T)

Lab_test_GMO <- read_excel("SmartFarming/OCA/2017-2018/2017-2018/01. C&A/01. Cropin default download/Lab test GMO.xlsx")

sale_of_organic_cotton <- read_excel("SmartFarming/OCA/2017-2018/2017-2018/01. C&A/01. Cropin default download/sale of organic cotton.xlsx")
View(sale_of_organic_cotton)

Organic_certification <- read_excel("SmartFarming/OCA/2017-2018/2017-2018/01. C&A/01. Cropin default download/Organic Certification.xlsx")



# Merging C&A
# Merge data with similar columns to columns to avoid x and y attached to column names. 


c1 <-merge(Farmer_details, Harvest_details, all = TRUE)
c2<- merge(c1, Lab_test_GMO, all = TRUE) 
c3<- merge(c2, sale_of_organic_cotton, all = TRUE) 
c4 <- merge(c3, Organic_certification, all = TRUE)

# Export All CA merged files
CAmerge<- export(c4, "OCA_CAmerge.xlsx")

##H&M##

Farmer_Details_H <- read_excel("SmartFarming/OCA/2017-2018/2017-2018/02. H&M/01. Cropin default download/Farmer details.xlsx")
str(Farmer_Details_H)

Gmo_test_H <- read_excel("SmartFarming/OCA/2017-2018/2017-2018/02. H&M/01. Cropin default download/Gmo Test.xlsx")

Harvest_detail_HM <- read_excel("SmartFarming/OCA/2017-2018/2017-2018/02. H&M/01. Cropin default download/Harvest detail_HM.xlsx")

Organic_Certification_H <- read_excel("SmartFarming/OCA/2017-2018/2017-2018/02. H&M/01. Cropin default download/Organic Certification.xlsx")
Sale_of_Organic_Cotton_H <- read_excel("SmartFarming/OCA/2017-2018/2017-2018/02. H&M/01. Cropin default download/Sale of Organic Cotton.xlsx")

#Merging H&M#

h1<- merge(Farmer_Details_H, Gmo_test_H, all = TRUE) 
h2<- merge(h1, Gmo_test_H, all = TRUE) 
h3<- merge(h2, Harvest_detail_HM, all = TRUE)
h4<- merge(h3, Organic_Certification_H, all = TRUE)
h5<- merge(h4, Organic_Certification_H, all = TRUE)
h6<- merge(h5, Sale_of_Organic_Cotton_H, all = TRUE)

# Export All HM merged files
HM_merge<- export(h6, "OCA_HMmerge.xlsx")

##Inditex##

Farmer_details_I <- read_excel("SmartFarming/OCA/2017-2018/2017-2018/03. Inditex/01. Cropin default download/Farmer_Details Report.xlsx")

Harvest_Details_I <- read_excel("SmartFarming/OCA/2017-2018/2017-2018/03. Inditex/01. Cropin default download/Harvest_Details (8).xlsx")

Organic_certification_I <- read_excel("SmartFarming/OCA/2017-2018/2017-2018/03. Inditex/01. Cropin default download/Organic Certification.xlsx")

Sale_of_organic_cotton_I <- read_excel("SmartFarming/OCA/2017-2018/2017-2018/03. Inditex/01. Cropin default download/Sale of organic cotton.xlsx")
##merging Inditex files

i1<- merge(Harvest_Details_I, Farmer_details_I, all = TRUE)
i2<- merge(i1, Organic_certification_I, all = TRUE)
i3<- merge(i2,Sale_of_organic_cotton_I, all = TRUE)


# Export All CA merged files
Inditexmerge<- export(i3, "OCA_ITXmerge.xlsx")

##Tchibo##


Farmer_Details_T <- read_excel("SmartFarming/OCA/2017-2018/2017-2018/04. Tchibo/01. Cropin default download/Farmer_Details.xlsx")

Gmo_test_T <- read_excel("SmartFarming/OCA/2017-2018/2017-2018/04. Tchibo/01. Cropin default download/GMO Test (Tchibo).xlsx")

Harvest_Details_T <- read_excel("SmartFarming/OCA/2017-2018/2017-2018/04. Tchibo/01. Cropin default download/Harvest_Details.xlsx")

Harvest_tchibo <- Harvest_Details_T %>% 
  group_by(farmercode, variety, plotname, harvest_season, crop, state, IP_name, brand_name, proj_id, cotton_type) %>% 
  summarise(harvest_quantity = sum(harvest_quantity), 
            cotton_plot =sum(cotton_plot),
            per_area_yield = sum(per_area_yield))


Farmer_SOC_T <- read_excel("SmartFarming/OCA/2017-2018/2017-2018/04. Tchibo/01. Cropin default download/Farmer_SOC.xlsx")

##Merging Tchibo files

t1<- merge(Farmer_Details_T, Gmo_test_T, all = TRUE)
t2<- merge(t1,Harvest_tchibo, all = TRUE)
t3<- merge(t2,Farmer_SOC_T, all = TRUE)


# Export All Tchibo merged files
Tchibomerge<- export(t3, "OCA_Tchmerge.xlsx")
#Checking uniqueness of merged files
glimpse(OCA_Tchmerge)

#Merging all brand files
OCA_CAmerge <- read_excel("OCA_CAmerge.xlsx")
OCA_HMmerge <- read_excel("OCA_HMmerge.xlsx")
OCA_ITXmerge <- read_excel("OCA_ITXmerge.xlsx")
OCA_Tchmerge <- read_excel("OCA_Tchmerge.xlsx")
first <- merge(OCA_CAmerge,OCA_HMmerge, all = TRUE)
second <- merge(first, OCA_ITXmerge, all = TRUE)
third <- merge(second, OCA_Tchmerge, all = TRUE)

brand_merge<- export(third, "OCA_brandmerge.xlsx")


###2019-2020 files
h_m_mp_19 <- read_excel("SmartFarming/OCA/2019-2020/merged_h&m_mp_19.xlsx")
Farmer_Premium_Form_19 <- read_excel("SmartFarming/OCA/2019-2020/Farmer Premium Form.xlsx", 
                                     col_types = c("text", "numeric", 
                                                   "numeric", "text", "text", 
                                                   "text", "text", "text", "text", "text"))
H_M_HC_MP_Premium_19 <- read_excel("SmartFarming/OCA/2019-2020/H&M_HC_MP_Premium.xlsx", 
                                   col_types = c("text", "text", 
                                                 "numeric", "numeric", "text",
                                                 "text", "text", "text", "text", "text"))
IND_PSL_Plot_Details_19 <- read_excel("SmartFarming/OCA/2019-2020/IND_PSL_Plot_Details.xlsx", 
                                      col_types = c("text", "text","numeric",
                                                    "text","text","text","text", "text"))
IND_PSL_Procurement_19 <- read_excel("SmartFarming/OCA/2019-2020/IND_PSL_Procurement.xlsx")
ITX_AM_CC_Farmer_Premium_Form_19 <- read_excel("SmartFarming/OCA/2019-2020/ITX_AM_CC_Farmer_Premium_Form_distinct.xlsx", 
                                               col_types = c("text", "text", "text", 
                                                             "numeric", 
                                                             "numeric", "text", "text", "text", 
                                                             "text", "text"))
ITX_AM_CC_Plot_Details_19 <- read_excel("SmartFarming/OCA/2019-2020/ITX_AM_CC_Plot_Details_distinct.xlsx", 
                                        col_types = c("text", "numeric", 
                                                      "text", "text","text","text","text"))
Farmer_Details_19 <- read_excel("SmartFarming/OCA/2019-2020/Master_Farmer_Details.xlsx", 
                                col_types = c("text", "text", "numeric", 
                                              "text", 
                                              "text", "text", "text", "text"))
Procurement_Data_SIED_19 <- read_excel("SmartFarming/OCA/2019-2020/Procurement_Data_SIED_19_20_Final_OCA_distinct.xlsx", 
                                       col_types = c( "text", 
                                                      "text", "text","text", "numeric", 
                                                      "text","text","text","text", "text"))
SIPL_INDITEX_MH_INDEPTH_19 <- read_excel("SmartFarming/OCA/2019-2020/SIPL-INDITEX-MH-INDEPTH.xlsx", 
                                         col_types = c("text", "text", "text", 
                                                       "numeric", "text", 
                                                       "text", "text", "text", "text", 
                                                       "numeric", "text", "numeric", 
                                                       "text", "numeric", "numeric", "numeric", 
                                                       "numeric","numeric",  "text", "text", "text", 
                                                       "numeric", "numeric", "text", "text","text","text"))

#Merging 2019-2020 files
st<- merge(h_m_mp_19,Farmer_Premium_Form_19, all = TRUE)
nd<- merge(st,H_M_HC_MP_Premium_19, all = TRUE)
rd<- merge(nd, IND_PSL_Plot_Details_19, all = TRUE)
rth<- merge(rd,IND_PSL_Procurement_19, all = TRUE)
fth<- merge(rth, ITX_AM_CC_Farmer_Premium_Form_19, all = TRUE)
sth <- merge(fth, ITX_AM_CC_Plot_Details_19, all = TRUE)
vth <- merge(sth, Farmer_Details_19, all = TRUE)
eth <- merge(vth, Procurement_Data_SIED_19, all = TRUE)
nth <- merge(eth, SIPL_INDITEX_MH_INDEPTH_19, all = TRUE)

nth <- export(nth, "OCA_2019_2020merge.xlsx")


#Merging all files files

OCA_brandmerge <- read_excel("OCA_brandmerge.xlsx")
OCA_2019_2020merge <- read_excel("OCA_2019_2020merge.xlsx", 
                                 col_types = c("text", "text", "text", 
                                               "text", "text", "text", "text", "text", 
                                               "numeric", "text", "numeric", "numeric", 
                                               "numeric", "numeric", "numeric", 
                                               "text", "numeric", "text", "text", 
                                               "text", "numeric", "text", "text", 
                                               "numeric", "text", "numeric", "text", 
                                               "numeric", "text"))

OCA_2020_21merge <- read_excel("OCA_2020_21merge.xlsx", 
                               col_types = c("text", "text", "text", 
                                             "text", "text", "text", "text", "text", 
                                             "text", "text", "numeric", "numeric", 
                                             "text", "numeric", "text", "numeric", 
                                             "numeric", "text", "numeric", "text", 
                                             "text", "text", "numeric"))

OCA21_22merge <- read_excel("OCA21_22merge.xlsx", 
                            col_types = c("text", "text", "text", 
                                          "text", "text", "text", "numeric", 
                                          "text", "numeric", "text", "numeric", 
                                          "numeric", "text", "text", "text", 
                                          "numeric", "text", "text", "numeric", 
                                          "numeric", "numeric", "text", "text"))

ab <- merge(OCA_brandmerge,OCA_2019_2020merge, all= TRUE)
bc <- merge(ab, OCA_2020_21merge, all = TRUE)
cd <- merge(bc, OCA21_22merge, all = TRUE)
export(cd, "OCA_Allmerge.xlsx")
# 2020-2021 files 

# OCA 2020-2021 files
BST_HC_MP_20 <- read_excel("SmartFarming/OCA/2020-21/BST_HC_MP_distinct.xlsx")
HM_HC_20 <- read_excel("SmartFarming/OCA/2020-21/Farmer Details.xlsx", 
                       col_types = c("text", "text", 
                                     "numeric", 
                                     "text", "text", "text", "text", 
                                     "text", "text", "text", "text", "text"))
Farmer_Details_SIED_20 <- read_excel("SmartFarming/OCA/2020-21/Farmer Details_Idx_SIED_C.xlsx")
BST_STAC_Procurement_20 <- read_excel("SmartFarming/OCA/2020-21/Farmer Procurement_1_V2_Sakhara.xlsx")
Farmer_Procurement_2_20 <- read_excel("SmartFarming/OCA/2020-21/Farmer Procurement_2_V2_Alipur.xlsx")
Farmer_PlotDetails_Sdry_SIED_20 <- read_excel("SmartFarming/OCA/2020-21/Farmer&PlotDetails_Superdry_SIED_C.xlsx")
Farmer_Plot_Details_20 <- read_excel("SmartFarming/OCA/2020-21/Farmer_Plot_Details_distinct.xlsx")
H_M_HC_MP_20 <- read_excel("SmartFarming/OCA/2020-21/H&M_HC_MP.xlsx")
ITX_SIPL_plot_20 <- read_excel("SmartFarming/OCA/2020-21/IND_SIPL_MH_Farmer&PlotDetails.xlsx", 
                               col_types = c("text", "text", "numeric", 
                                             "text", "numeric", "text", "text", 
                                             "numeric", "text", "text", "text", 
                                             "text", "text", "text"))
Inditex_OD_20 <- read_excel("SmartFarming/OCA/2020-21/Inditex OR-Farmer&PlotDetails.xlsx", 
                            col_types = c("text", "text", "numeric", 
                                          "text", "numeric", "text", "text", 
                                          "numeric", "text", "text", "text", "text", 
                                          "text", "text"))
ITX_SIPL_MH_20 <- read_excel("SmartFarming/OCA/2020-21/ITX_SIPL_MH.xlsx")
ITX_SIPL_mh_20 <- ITX_SIPL_MH_20 %>% 
  group_by(farmercode,sale_season, MOP, proj_id,brand_name,state,IP_name, cotton_type) %>% 
  summarise(total_cotton_sold= sum(total_cotton_sold),
            `premium_income(Euro)`=sum(`premium_income(Euro)`),
            `premium_income(INR)` = sum(`premium_income(INR)`))
ITX_SIPL_OD_20 <- read_excel("SmartFarming/OCA/2020-21/ITX_SIPL_OD.xlsx")
ITX_SIPL_od_20 <- ITX_SIPL_OD_20 %>% 
  group_by(farmercode,sale_season, MOP, proj_id,brand_name,state,IP_name, cotton_type) %>% 
  summarise(total_cotton_sold= sum(total_cotton_sold),
            `premium_income(Euro)`=sum(`premium_income(Euro)`),
            `premium_income(INR)` = sum(`premium_income(INR)`))

BST_STAC_Harvest_20 <- read_excel("SmartFarming/OCA/2020-21/Plot Harvest Form_Allipur.xlsx", 
                                  col_types = c("text", "text", "numeric", 
                                                "numeric", "numeric", "text","text","text","text","text","text", "text","text"))
BST_Harvest_2_20 <- read_excel("SmartFarming/OCA/2020-21/Plot Harvest Form_Sakhra.xlsx", 
                               col_types = c("text", "text", "numeric", 
                                             "numeric", "numeric", "text","text","text","text","text","text", "text","text"))
ITX_PSL_20 <- read_excel("SmartFarming/OCA/2020-21/Plot Level Organic Certi_1.xlsx", 
                         col_types = c("text", "text","text","text","text","text","text"))

#merging 2020-21 files
tw1 <- merge(BST_HC_MP_20,HM_HC_20, all= TRUE)
tw2 <- merge(tw1, Farmer_Details_SIED_20, all= TRUE)
tw3 <- merge(tw2, BST_STAC_Procurement_20, all= TRUE)
tw4 <- merge(tw3, Farmer_Procurement_2_20, all= TRUE)
tw5 <- merge(tw4, Farmer_PlotDetails_Sdry_SIED_20, all= TRUE)
tw6 <- merge(tw5,Farmer_Plot_Details_20, all= TRUE)
tw7 <- merge(tw6, ITX_PSL_20, all= TRUE)
tw8 <- merge(tw7, BST_Harvest_2_20, all= TRUE)
tw9 <- merge(tw8, H_M_HC_MP_20, all= TRUE)
tw10 <- merge(tw9, ITX_SIPL_plot_20, all= TRUE)
tw11 <- merge(tw10, Inditex_OD_20, all= TRUE)
tw12 <- merge(tw11, ITX_SIPL_mh_20, all= TRUE)
tw13 <- merge(tw12, ITX_SIPL_od_20, all= TRUE)
tw14 <- merge(tw13, BST_STAC_Harvest_20, all= TRUE)
#tw15 <- merge(tw14, BST_Harvest_2_20, all= TRUE)
#tw16 <- merge(tw15, ITX_PSL_20, all= TRUE)

export(tw14, "OCA_2020_21merge.xlsx")

#Merging 2017-2018, 2019-2020 and 2020-21 files


#Merging up to 2021 files
ABC <- merge(OCA_2017_2020merge,OCA_2020_21merge, all = TRUE)
export(ABC, "OCAupto21merge.xlsx")

#Loading 2021-22 files
BST_HC_MP_OC_21 <- read_excel("SmartFarming/OCA/2021-22/BST_HC_MP_OC_21.xlsx", 
                              col_types = c( "text", "text", "numeric", 
                                             "numeric", "text", "numeric", 
                                             "text", "text", "text", "text", 
                                             "text", "text"))
BST_STAC_MH_IC_21 <- read_excel("SmartFarming/OCA/2021-22/BST_STAC_MH_IC_21.xlsx", 
                                col_types = c( "text", 
                                               "numeric", "text", "text", "numeric", 
                                               "numeric", "numeric", "text", "text", 
                                               "text", "text", "text", "text", "text"))
BST_STAC_MH_OC_21 <- read_excel("SmartFarming/OCA/2021-22/BST_STAC_MH_OC_21.xlsx") 

CA_AM_AKF_MP_OC_21 <- read_excel("SmartFarming/OCA/2021-22/CA_AM_AKF_MP_OC_21.xlsx")
CA_AM_SOLI_MH_OC_2_21 <- read_excel("SmartFarming/OCA/2021-22/CA_AM_SOLI_MH_OC_2_21.xlsx")
CA_AM_SOLI_MH_OC_21 <- read_excel("SmartFarming/OCA/2021-22/CA_AM_SOLI_MH_OC_21.xlsx") 

Farmer_Details_ITX_SIPL_OD_OC_21 <- read_excel("SmartFarming/OCA/2021-22/Farmer_Details_ITX_SIPL_OD_OC_21.xlsx", 
                                               col_types = c("text", "text", 
                                                             "numeric", "text", "numeric", "text", 
                                                             "text", "text", "text", "text", "numeric", 
                                                             "text", "numeric","text", "text", "text", "text"))
Farmer_procurement_CA_AM_AKF_MP_OC_21 <- read_excel("SmartFarming/OCA/2021-22/Farmer_procurement_CA_AM_AKF_MP_OC_21.xlsx", 
                                                    col_types = c("text", "text", "numeric", 
                                                                  "numeric", "text", 
                                                                  "text", "text", "text", "text", "text"))
Farmer_Procurement_HM_ASA_MP_OC_21 <- read_excel("SmartFarming/OCA/2021-22/Farmer_Procurement_HM_ASA_MP_OC_21.xlsx", 
                                                 col_types = c("text", "numeric", 
                                                               "text", "numeric", "numeric","text","text","text","text","text", "text"))
Farmer_Procurement_ITX_SIPL_OD_OC_21 <- read_excel("SmartFarming/OCA/2021-22/Farmer_Procurement_ITX_SIPL_OD_OC_21.xlsx", 
                                                   col_types = c("text", "numeric", "numeric", 
                                                                 "numeric", "text", "text","text","text","text","text","text"))
Harvest_21 <- read_excel("SmartFarming/OCA/2021-22/Harvest_21.xlsx", 
                         col_types = c("text", "text", "numeric", "text", "numeric", 
                                       "numeric", "text", "text","text","text","text","text"))
HM_ASA_MP_OC_21 <- read_excel("SmartFarming/OCA/2021-22/HM_ASA_MP_OC_21.xlsx", 
                              col_types = c("text", "text", 
                                            "numeric", 
                                            "text", "numeric", "text", 
                                            "text", "numeric", "text", "text", 
                                            "text", "text", "text", "text"))
HM_HC_MP_OC_21 <- read_excel("SmartFarming/OCA/2021-22/HM_HC_MP_OC_21.xlsx")
ITX_AM_SIED_MH_OC_21 <- read_excel("SmartFarming/OCA/2021-22/ITX_AM_SIED_MH_OC_21.xlsx", 
                                   col_types = c("text", "text", 
                                                 "numeric", "text", "numeric", "text", 
                                                 "text", "numeric", "text", "text", 
                                                 "text", "text", "text",
                                                 "numeric", "numeric", "numeric", 
                                                 "numeric", "text", "text", "text", 
                                                 "text", "text"))
ITX_AM_TCMF_MH_IC_21 <- read_excel("SmartFarming/OCA/2021-22/ITX_AM_TCMF_MH_IC_21.xlsx", 
                                   col_types = c("text", "text", 
                                                 "numeric", "text", "numeric", 
                                                 "text",  "numeric", "text", 
                                                 "text", "text", "text", "text", "text"))
ITX_HC_MP_OC_21 <- read_excel("SmartFarming/OCA/2021-22/ITX_HC_MP_OC_21.xlsx", 
                              col_types = c("text", "text", 
                                            "numeric", "text", "numeric",
                                            "text", "text", "text", "text","text", "numeric", 
                                            "text", "text"))
ITX_PSL_RJ_OC_21 <- read_excel("SmartFarming/OCA/2021-22/ITX_PSL_RJ_OC_21.xlsx", 
                               col_types = c("text", "text", "numeric", 
                                             "text", "text", "text", "text", "text", 
                                             "text", "numeric", "text", 
                                             "text", 
                                             "numeric", "text", "numeric",
                                             "text", "text", "numeric", "numeric"))
KB_SUM_OD_OC_21 <- read_excel("SmartFarming/OCA/2021-22/KB_SUM_OD_OC_21.xlsx", 
                              col_types = c("text", "text", 
                                            "numeric", "text", "numeric", "text", "text", 
                                            "text", "text", "text", "numeric", 
                                            "text", "text"))
Plot_Level_Organic_Certi_ITX_SIPL_MH_OC_21 <- read_excel("SmartFarming/OCA/2021-22/Plot Level Organic Certi_ITX_SIPL_MH_OC.xlsx", 
                                                         col_types = c("text", "text", "text", 
                                                                       "text", "numeric", "numeric", "text", 
                                                                       "numeric", "text", "numeric", 
                                                                       "text", "numeric", "text", 
                                                                       "text", "text", "text", "text", "text", 
                                                                       "numeric", "numeric", 
                                                                       "numeric", "text", "text"))

Plot_Harvest_21 <- read_excel("SmartFarming/OCA/2021-22/Plot_Harvest_21.xlsx", 
                              col_types = c("text", "text",  
                                            "numeric", "numeric", "numeric", "text", "text", "text", "text", "text", "text"))
Plot_Harvest_CA_AM_SOLI_MH_OC_21 <- read_excel("SmartFarming/OCA/2021-22/Plot_Harvest_CA_AM_SOLI_MH_OC_21.xlsx")
Plot_HM_KB_MH_OC_21 <- read_excel("SmartFarming/OCA/2021-22/Plot_HM_KB_MH_OC_21.xlsx", 
                                  col_types = c("text", "text", "text", 
                                                "text","text", "numeric", "text", 
                                                "numeric", "numeric", "text", "text", 
                                                "numeric","numeric", 
                                                "numeric", "text", "text", "text", 
                                                "text", "text"))
Plot_Info_Details_1_21 <- read_excel("SmartFarming/OCA/2021-22/Plot_Info_Details_1_21.xlsx")
Plot_Info_Details_21 <- read_excel("SmartFarming/OCA/2021-22/Plot_Info_Details_21.xlsx", 
                                   col_types = c("text", "text", 
                                                 "numeric", 
                                                 "text", "text","text","text","text","text","text"))
Plot_ITX_AM_WWF_MP_OC_21 <- read_excel("SmartFarming/OCA/2021-22/Plot_ITX_AM_WWF_MP_OC_21.xlsx", 
                                       col_types = c("text", "text", "text", 
                                                     "numeric", "text", "text", "numeric", 
                                                     "text", "text", "text", "text", 
                                                     "text"))
Plot_ITX_PA_OD_IC_21 <- read_excel("SmartFarming/OCA/2021-22/Plot_ITX_PA_OD_IC_21.xlsx", 
                                   col_types = c("text", "text", "text", 
                                                 "text","text", "numeric", "numeric", "text", 
                                                 "numeric", "numeric",
                                                 "text", "numeric", "numeric", "text", 
                                                 "text", 
                                                 "numeric", "numeric", "text", "text", 
                                                 "text", "text"))
Plot_ITX_STAC_MH_IC_21 <- read_excel("SmartFarming/OCA/2021-22/Plot_ITX_STAC_MH_IC_21.xlsx", 
                                     col_types = c("text", "text", "text", 
                                                   "text", "text" ,"numeric", "text", "text", 
                                                   "numeric", "text", "numeric", "text", 
                                                   "text", "text", "text", 
                                                   "numeric", "text", "text" 
                                     ))
Plot_ITX_STAC_MH_OC_21 <- read_excel("SmartFarming/OCA/2021-22/Plot_ITX_STAC_MH_OC_21.xlsx", 
                                     col_types = c("text", "text", "text", 
                                                   "text", "text", 
                                                   "numeric", "text","numeric", 
                                                   "numeric", "text", "numeric", "text", 
                                                   "numeric", "text", "numeric", "text", "text", "text", "text", 
                                                   "text", "text"))
Plot_Level_21 <- read_excel("SmartFarming/OCA/2021-22/Plot_Level_21.xlsx")
SDRY_AM_SIED_MH_OC_21 <- read_excel("SmartFarming/OCA/2021-22/SDRY_AM_SIED_MH_OC_21.xlsx", 
                                    col_types = c("text", "text", "numeric", 
                                                  "text", "numeric", 
                                                  "text", "text", 
                                                  "text", "text", "text", "text", "text", 
                                                  "text", "numeric", "text", 
                                                  "numeric", "numeric", "numeric", "numeric", 
                                                  "text", "numeric"))

#Merging 2021-22 files

t1<- merge(BST_HC_MP_OC_21,BST_STAC_MH_IC_21, all = TRUE)
t2<- merge(t1, BST_STAC_MH_OC_21, all = TRUE)
t3<- merge(t2, CA_AM_AKF_MP_OC_21, all = TRUE)
t4<- merge(t3, CA_AM_SOLI_MH_OC_21, all = TRUE)
t5<- merge(t4, CA_AM_SOLI_MH_OC_2_21, all = TRUE)
t6<- merge(t5, Farmer_Details_ITX_SIPL_OD_OC_21, all = TRUE)
t7<- merge(t6, Farmer_procurement_CA_AM_AKF_MP_OC_21, all = TRUE)
t8<- merge(t7, Farmer_Procurement_HM_ASA_MP_OC_21, all = TRUE)
t9<- merge(t8, Farmer_Procurement_ITX_SIPL_OD_OC_21, all = TRUE)
t10<- merge(t9, Harvest_21, all = TRUE)
t11<- merge(t10, HM_ASA_MP_OC_21, all = TRUE)
t12<- merge(t11, HM_HC_MP_OC_21, all = TRUE)
t13<- merge(t12, ITX_AM_SIED_MH_OC_21, all = TRUE)
t14<- merge(t13, ITX_AM_TCMF_MH_IC_21, all = TRUE)
t15<- merge(t14, ITX_HC_MP_OC_21, all = TRUE)
t16<- merge(t15, ITX_PSL_RJ_OC_21, all = TRUE)
t17<- merge(t16, KB_SUM_OD_OC_21, all = TRUE)
t18<- merge(t17, Plot_Level_Organic_Certi_21, all = TRUE)
t19<- merge(t18, Plot_Level_Organic_Certi_ITX_SIPL_MH_OC_21, all = TRUE)
t20<- merge(t19, Plot_ITX_STAC_MH_OC_21, all = TRUE)
t21<- merge(t20, Plot_ITX_STAC_MH_IC_21, all = TRUE)
t22<- merge(t21, SDRY_AM_SIED_MH_OC_21, all = TRUE)
t23<- merge(t22, Plot_Harvest_21, all = TRUE)
t24<- merge(t23, Plot_Harvest_CA_AM_SOLI_MH_OC_21, all = TRUE)
t25<- merge(t24, Plot_HM_KB_MH_OC_21, all = TRUE)
t26<- merge(t25, Plot_Info_Details_1_21, all = TRUE)
t27<- merge(t26, Plot_Info_Details_21, all = TRUE)
t28<- merge(t27, Plot_Level_21, all = TRUE)
t29<- merge(t28, Plot_ITX_AM_WWF_MP_OC_21, all = TRUE)
t30<- merge(t29, Plot_ITX_PA_OD_IC_21, all = TRUE)
#t31<- merge(t30, Plot_ITX_STAC_MH_IC_21, all = TRUE)
#t32<- merge(t31, Plot_ITX_STAC_MH_OC_21, all = TRUE)
#t33<- merge(t32, Plot_Level_21, all = TRUE)
#t34<- merge(t33, Plot_Level_Organic_21, all = TRUE)


#Export 
export(t30, "OCA21_22merge.xlsx")

#Merging all files


#Merge ALL files
all<- merge(OCAupto21merge,OCA21_22merge, all = TRUE)
#all_unique<- unique(all)
export(all, "IP_masterfile.xlsx")


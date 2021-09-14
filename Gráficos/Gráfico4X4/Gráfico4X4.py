from matplotlib import pyplot as plt
import numpy as np
import pandas as pd
import seaborn as sns
#import tensorflow as tf

filename = 'iris.csv'
csv_data = pd.read_csv(filename, sep = ',')
#print(csv_data.head())

column_names = ['comprimento_sépala', 'largura_sépala', 'comprimento_pétala', 'largura_pétala','espécies']
csv_data.columns = column_names

#sns.pairplot(csv_data)
sns.set(style="ticks", color_codes=True)
sns.pairplot(csv_data, hue='espécies', palette ="husl")


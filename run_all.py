import sys

import numpy as np
import pandas as pd

from coffee.recommender.data import RecommenderData, RecommenderDataPositive
from coffee.recommender.models import SVDModel, CoffeeModel, NonPersonalized
from coffee.evaluation import evaluation_engine as ee
from coffee.tools.mymedialite.mmlwrapper import MyMediaLiteWrapper
from coffee.tools.movielens import get_movielens_data
from coffee.evaluation.plotting import show_hit_rates, show_precision_recall, show_ranking

DATA_NAME = 'ml-1m'
DATA_FILE = '{}.zip'.format(DATA_NAME)#path to Movielens-1M zip-file, set to None to automatically download it from Grouplens

ml_data = get_movielens_data(local_file=DATA_FILE, get_genres=False)

def filter_by_length(data, user_id='userid', session_length=20):
    """Filters users with insufficient number of items"""
    sz = data.groupby(user_id, sort=False).size()
    short_sessions = sz < session_length
    if (short_sessions < session_length).any():
        valid_users = sz.index[(sz > session_length)]
        new_data =  data[data.userid.isin(valid_users)]
        print 'Sessions are filtered by length'
    else:
        new_data = data
    return new_data
    

ml_data = filter_by_length(ml_data)
data_model = RecommenderData(ml_data, 'userid', 'movieid', 'rating')
data_model.name = DATA_NAME

#set path to MyMediaLite binaries
if sys.platform == 'win32':
    LIB_PATH = 'MyMediaLite-3.11/lib/mymedialite' 
else:
    LIB_PATH = 'MyMediaLite-3.11/bin'

MML_DATA = 'MyMediaLiteData' #folder to store MyMediLite data (models, data mappings, etc.)

bpr = MyMediaLiteWrapper(LIB_PATH, MML_DATA, 'BPRMF', data_model)
wrmf = MyMediaLiteWrapper(LIB_PATH, MML_DATA, 'WRMF', data_model)
svd = SVDModel(data_model)
popular =  NonPersonalized('mostpopular', data_model)
random = NonPersonalized('random', data_model)
coffee = CoffeeModel(data_model)

models = [bpr, wrmf, svd, coffee, popular, random]
model_names = [model.method for model in models]
metrics = ['hits', 'ranking', 'relevance']
model_names

for model in models[:4]:
    try:
        rank = model.rank
    except AttributeError:
        rank = model.mlrank
        
print '{} rank: {}'.format(model.method, rank)

topk_list = [1, 2, 3, 5, 10, 15, 20, 30, 50, 70, 100]
test_samples = [-1, 0]
folds = [1, 2, 3, 4, 5]

data_model.holdout_size = 10
data_model.random_holdout = True

RESULTS_DIR = 'results'
EXPERIMENT_NAME = 'TEST'

result = {}
topk_result = {}
for test_sample in test_samples:
    data_model.test_sample = test_sample
    print '\n\n========= Test sample: {} =========\n'.format(test_sample)
    for fold in folds:
        print '\n============ Fold: {} ============='.format(fold)
        data_model.test_fold = fold
        topk_result[fold] = ee.topk_test(models, topk_list=topk_list, metrics=metrics)
    result[test_sample] = ee.consolidate_folds(topk_result, folds, metrics)

ee.save_scores(result, DATA_NAME, EXPERIMENT_NAME, save_folder=RESULTS_DIR)
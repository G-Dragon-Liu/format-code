
prefix=/root/ori/mindspore/
dataset_name=places365

#项目目录
# prefix=/root/ori/phototour/mindspore/
# #数据集的名字
# dataset_name=phototour
cd $prefix
echo $PWD

array=(mindspore/ccsrc/minddata/dataset/engine/datasetops/source/${dataset_name}_op.cc
mindspore/ccsrc/minddata/dataset/engine/datasetops/source/${dataset_name}_op.h

mindspore/ccsrc/minddata/dataset/engine/ir/datasetops/dataset_node.h
mindspore/ccsrc/minddata/dataset/engine/ir/datasetops/source/${dataset_name}_node.cc
mindspore/ccsrc/minddata/dataset/engine/ir/datasetops/source/${dataset_name}_node.h

mindspore/ccsrc/minddata/dataset/api/datasets.cc
mindspore/ccsrc/minddata/dataset/include/dataset/datasets.h
mindspore/ccsrc/minddata/dataset/include/dataset/samplers.h

mindspore/ccsrc/minddata/dataset/api/python/bindings/dataset/engine/ir/datasetops/source/bindings.cc


tests/ut/cpp/dataset/c_api_dataset_${dataset_name}_test.cc
tests/ut/cpp/dataset/${dataset_name}_op_test.cc)

for file in ${array[@]}
do
    echo ${file}
    clang-format -style=file -i  $prefix${file}
done


#bash -x scripts/check_clang_format.sh -l

#cpplint

for file in ${array[@]}
do
    echo ${file}
    cpplint --repository=${prefix} --linelength=120 ${file}
done


pyfiles=(
    # mindspore/dataset/engine/validators.py
    # mindspore/dataset/engine/datasets.py
    tests/ut/python/dataset/test_datasets_${dataset_name}.py
)

for file in ${pyfiles[@]}
do
    echo ${file}
    pylint --rcfile=/root/format_code/pylintrc -j 4 --output-format=parseable ${file}
done
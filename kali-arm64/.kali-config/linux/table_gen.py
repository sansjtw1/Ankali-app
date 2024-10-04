# Copyright (c) 2024 Ankali SansJtw
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
# Email: sansjtw@163.com, sansjtw1@gmail.com
import sys
from prettytable import PrettyTable

def create_table(headers, rows):
    table = PrettyTable()

    # 动态检测最大列数
    max_cols = max(len(row) for row in rows)

    # 如果没有提供表头，根据最大列数自动生成表头
    if not headers:
        headers = [f"列{i+1}" for i in range(max_cols)]

    table.field_names = headers

    # 填充行数据，确保每行的列数一致，不足的地方用空字符串补齐
    for row in rows:
        if len(row) < max_cols:
            row += [''] * (max_cols - len(row))  # 补齐空值
        table.add_row(row)

    print(table)

if __name__ == "__main__":
    # 获取命令行参数中的表头和行数据
    if len(sys.argv) > 1:
        headers = sys.argv[1].split(',')  # 获取表头，如果传入表头
    else:
        headers = []  # 如果未传入表头，设置为空

    # 获取行数据，并通过逗号分割每一行
    rows = [row.split(',') for row in sys.argv[2:]]  # 分割行内容

    create_table(headers, rows)

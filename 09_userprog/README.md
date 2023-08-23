由于原书的 gcc 版本太低导致 elf 文件结构差异巨大，故需要使用低版本 gcc 编译，经过搜索得知 gcc4.4 可用，于是起了个虚拟机装 gcc4.4 在里面编译
- 还在研究怎么通过 ssh 自动化编译


在有 gcc4.4 的环境下
```shell
make all
```
将生成的`build`目录移动到 bochs 工作环境

```shell
./build.sh
```
原书给出的代码运行得很快会刷屏，这是在`main`中通过无关变量自减来拖延时间方便观察，`_build`目录中有原书代码版本
调试窗口有在`u_prog_a`下断点的调试结果（注意加延时代码时候`u_prog_a`的地址变化成`0xc0001619`，通过 IDA 反汇编`main.o`可以找到）
![result](./img/result.png)
# ArkTs 基础知识

## 渲染控制语法

1. 循环渲染：

`ForEach(arr, itemGenerator, keyGenerator)` 由循环的数据源`arr`，子组件迭代器`itemGenerator`和唯一`key`
生成器三部分组成，下面是一段简单的示例代码，通过循环`languages`数据源生成每一个`Text`子组件。

```arkts
languages: Array<string> = ['JavaScript', 'Typescript', 'ArkTs'];

ForEach(this.languages, (item: any, index: number) => {
    Text(`${index}, ${item}`)
      .fontSize(30)
      .fontWeight(FontWeight.Bold)
}, (item: any, index: number) => item)

```

2. 条件渲染

在上面案例的基础上通过 `if () else ()` 语法为其增加渲染条件，当循环到`item`为`ArkTs`时将`Text`组件显示的颜色变为红色。

```arkts
if (item === 'ArkTs') {
    Text(`${index}, ${item}`)
      .fontSize(30)
      .fontColor('red')
      .fontWeight(FontWeight.Bold)
} else {
    Text(`${index}, ${item}`)
      .fontSize(30)
      .fontWeight(FontWeight.Bold)
}
```

## 状态管理装饰器

1. @State：用来描述组件内容的状态属性，当这个属性的状态发生变化时，将会调用当前组件的`build`方法进行UI刷新。

首先定义一个普通的属性和一个组件内的状态属性；

```arkts
allLanguages: Array<string> = ['JavaScript', 'Typescript', 'ArkTs'];
@State languages: Array<string> = [];
```

接着通过两个按钮来为状态属性`languages`添加和删除元素；

```arkts
ForEach(this.languages, (item: any, index: number) => {
  Text(`${index}, ${item}`)
    .fontSize(30)
    .fontWeight(FontWeight.Bold)
}, (item: any, index: number) => item)
Button("添加新语言").onClick(() => {
  const popItem = this.allLanguages.pop();
  if (popItem) {
    this.languages.push(popItem);
  }
})
Button("删除旧语言").onClick(() => {
  const popItem = this.languages.pop();
  if (popItem) {
    this.allLanguages.push(popItem);
  }
})
```

2. @Prop：用来在子组件中描述接收一个父组件传入的状态属性，允许在子组件中修改@Prop描述的状态属性但不会通知父组件，即形成了单向数据流的效果。


3. @Link：
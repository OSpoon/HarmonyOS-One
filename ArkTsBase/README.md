# ArkTs 基础知识

## 渲染控制语法

1. 循环渲染：

语法：`ForEach(arr, itemGenerator, keyGenerator)`

由循环的数据源`arr`，子组件迭代器`itemGenerator`和唯一`key`
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

首先在前面案例的基础上定义一个普通的属性和一个组件内的状态属性；

```arkts
// 普通的属性
allLanguages: Array<string> = ['JavaScript', 'Typescript', 'ArkTs'];
// 组件内的状态属性
@State languages: Array<string> = [];
```

接着通过两个按钮来为`languages`添加和删除元素；

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

首先还是创建一个`ChildComponent`子组件，在其内部使用`@Prop`描述一个提供给父组件来初始化的`counter`状态属性。

```arkts
@Component
export default struct ChildComponent {
  // 禁止在组件内初始化，应由父组件进行初始化
  @Prop counter: number;

  build() {
    Column() {
      Text('ChildComponent')
        .fontSize(30)
        .fontWeight(FontWeight.Bold);
      Text(this.counter + '')
        .fontSize(25)
        .fontWeight(FontWeight.Bold);
      Button('update child status in child')
        .onClick(() => {
          this.counter++;
        })
    }
    .border({
      width: 1,
      color: '#cccccc',
      style: BorderStyle.Solid
    })
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .height(200)
  }
}
```

接着在父组件导入`ChildComponent`子组件，且使用`@State`描述一个状态属性为子组件的`counter`提供初始化。

```arkts
import ChildComponent from '../components/ChildComponent';

@State childCounter: number = 0;

ChildComponent({
  counter: this.childCounter
})
Button("update child status in parent")
  .margin({ top: 10 })
  .onClick(() => {
    this.childCounter++;
  })
```

通过分别触发父子组件提供的更新状态的按钮可以发现，在子组件更新的状态不会同步父组件，但父组件的更新会覆盖子组件的更新。

3. @Link：
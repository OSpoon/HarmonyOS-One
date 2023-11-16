import ChildComponent from '../components/ChildComponent';

@Entry
@Component
struct Index {
  // allLanguages: Array<string> = ['JavaScript', 'Typescript', 'ArkTs'];
  // @State languages: Array<string> = [];
  @State childCounter: number = 0;

  build() {
    Row() {
      Column() {
        // ForEach(this.languages, (item: any, index: number) => {
        //   Text(`${index}, ${item}`)
        //     .fontSize(30)
        //     .fontWeight(FontWeight.Bold)
        // }, (item: any, index: number) => item)
        // Button("添加新语言").onClick(() => {
        //   const popItem = this.allLanguages.pop();
        //   if (popItem) {
        //     this.languages.push(popItem);
        //   }
        // })
        // Button("删除旧语言").onClick(() => {
        //   const popItem = this.languages.pop();
        //   if (popItem) {
        //     this.allLanguages.push(popItem);
        //   }
        // })
        ChildComponent({
          counter: this.childCounter
        })
        Button("update child status in parent")
          .margin({ top: 10 })
          .onClick(() => {
            this.childCounter++;
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}
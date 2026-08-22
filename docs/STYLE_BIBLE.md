# STYLE_BIBLE · 风格宪法

> **本文件是所有提示词的唯一来源。** 写任何镜头的提示词时，人物锁定句、场景锚定句、全局风格后缀、负向词都必须从这里**原样复制**，禁止即兴改写。要改风格，只改这里并升版本号，然后通知所有人。

- 版本：v1（2026-08-22）
- 依据：`character-assets/*/CHARACTER_LOCK.md` v1 + 讨论会画风定稿

---

## 1. 全局风格后缀（每条提示词末尾必拼）

```
Photorealistic live-action Chinese family sitcom style, modern urban apartment interior, warm beige walls, light wood furniture, soft warm window light mixed with warm ceiling lamp, shallow depth of field, low saturation, Sony camera look, natural skin pores and hair strands, vertical 9:16 composition
```

要点：超写实真人摄影风；暖米色+浅木色调；竖屏 9:16。**禁止**卡通/3D/Q版/网红磨皮脸。

## 2. 负向提示（每条提示词末尾必拼）

```
Negative: cartoon, anime, 3D render, CGI, chibi, doll face, idol face, heavy makeup, text, watermark, logo, extra fingers, deformed hands
```

## 3. 人物锁定句（从 CHARACTER_LOCK.md 同步，禁改）

> 用法：镜头里谁出现，就把谁的锁定句整段放进提示词。挂参考图清单见 `character-assets/manifest.json`。

### 爸爸 · 周磊（38岁）
```
Photorealistic Chinese man age 38, square-round face, thick eyebrows, inner double eyelids, warm wheat skin, light stubble on jaw, short side-part hair slightly thinning on crown, dark gray crew-neck home t-shirt, black sweatpants, mechanical wristwatch on left wrist, natural pores, Sony camera look, soft window light, not cartoon not 3D
```

### 妈妈 · 陈晓月（36岁）
```
Photorealistic Chinese woman age 36, oval face, natural double eyelids, small straight nose, warm fair skin, faint dimple on left cheek when smiling, shoulder-length black straight hair worn down with soft wispy bangs, cream knit cardigan over light khaki homewear, small silver stud earrings, natural pores, Sony camera look, soft window light, not cartoon not 3D
```

### 哥哥 · 周浩宇（10岁）
```
Photorealistic Chinese boy age 10, round face, thick eyebrows, inner double eyelids, warm skin tone, neat short schoolboy hair with soft bangs, blue sports t-shirt with minimal print and dark gray shorts, natural pores and hair strands, natural Chinese child proportions, Sony camera look, soft window light, not cartoon not 3D not CGI
```

### 妹妹 · 周思琪（7岁）
```
Photorealistic Chinese girl age 7, oval face, natural double eyelids, faint left cheek dimple, warm fair skin, shoulder-length black straight hair with short bangs and two small light-pink hair clips, cream or soft pink homewear set, natural child proportions, Sony camera look, soft window light, not cartoon not 3D not CGI
```

## 4. 场景锚定句（周家固定场景，禁改）

### SCENE-KITCHEN 厨房（EP01 主场景）
```
Modern Chinese apartment kitchen after dinner, warm beige walls, light wood cabinets, stainless steel sink area, gas cooktop with range hood, kettle and dish rack on counter, warm ceiling lamp plus evening glow from a small window, lived-in family kitchen feel
```

### SCENE-LIVINGROOM 客厅
```
Living room of a modern Chinese apartment, beige fabric sofa with one dark gray throw blanket draped on the armrest, light wood coffee table with a TV remote, wall-mounted TV, warm floor lamp in the corner, cozy evening atmosphere
```

### SCENE-DINING 餐桌
```
Dining area of a modern Chinese apartment, light wood dining table with four chairs, simple white ceramic dishes and bowls, warm pendant light above the table, open view to the beige living room in the background
```

## 5. 记忆点道具表（出现即必写进提示词）

| 角色/位置 | 道具 | 英文写法 |
|-----------|------|----------|
| 爸 | 机械腕表（不离手） | `mechanical wristwatch` |
| 妈 | 小巧银色耳钉 | `small silver stud earrings` |
| 妹 | 浅粉抓夹×2 + 米色兔子玩偶 | `two small light-pink hair clips`, `beige bunny plush` |
| 客厅沙发 | 深灰毯子 | `dark gray throw blanket` |

## 6. 运镜白名单（只允许这些词）

```
static shot / slow push-in / slow pull-back / handheld slight shake / gentle pan left-right / tilt down
```

不发明复杂调度。一镜一事：8 秒最多演 1 个动作节拍。

## 7. 提示词标准骨架

每镜提示词按此顺序组装：

```
[1 全局风格开头一句] + [2 场景锚定句] + [3 人物锁定句(出场者)] +
[4 动作与表情(本镜唯一事件)] + [5 口型动作说明(无声) ] +
[6 运镜] + [7 音频环境音说明(无对白)] + [8 负向词]
```

示例见 `episodes/EP01-xiwan/prompts/SH01.md`。

## 8. 改版记录

| 版本 | 日期 | 变更 |
|------|------|------|
| v1 | 2026-08-22 | 初版，同步 character-assets v1 锁定内容 |

class GunType < ActiveHash::Base
  self.data = [
    {id: 0, name: "???", ruby: "???"},
    {id: 1, name: "アサルトライフル", ruby: "アサルトライフル"},
    {id: 2, name: "自動小銃", ruby: "ジドウショウジュウ"},
    {id: 3, name: "ショットガン", ruby: "ショットガン"},
    {id: 4, name: "パーカッションロック", ruby: "パーカッションロック"},
    {id: 5, name: "火縄銃", ruby: "ヒナワジュウ"},
    {id: 6, name: "フリントロック", ruby: "フリントロック"},
    {id: 7, name: "変形銃", ruby: "ヘンケイジュウ"},
    {id: 8, name: "ボルトアクション", ruby: "ボルトアクション"},
    {id: 9, name: "マスケット", ruby: "マスケット"},
    {id: 10, name: "ライフル", ruby: "ライフル"},
    {id: 11, name: "リボルバー", ruby: "リボルバー"}
  ]
end

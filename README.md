專案簡介
此專案模擬好友列表功能，依據不同資料狀態呈現畫面，包含邀請列表、好友列表、空資料預設畫面，並整合 API 資料彙整邏輯。專案架構採用 MVVM 架構，搭配 Combine 實作非同步資料處理與綁定，並使用 CollectionView 實現動態畫面更新。

主要需求
- 無好友畫面（API 2-(5)）
- 只有好友列表（API 2-(2)、2-(3) 合併，依據 fid 取 updateDate 較新資料）
- 好友列表含邀請（API 2-(4)）
- 搜尋功能：對好友姓名進行關鍵字搜尋

技術架構
- MVVM 架構
- 使用 Combine 處理非同步資料請求與資料綁定
- 使用 UICollectionViewDiffableDataSource 管理資料更新
- 使用 UIRefreshControl 達成下拉更新功能
- 使用 UICollectionViewCompositionalLayout 實現多 section 動態列表


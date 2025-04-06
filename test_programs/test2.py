import plotly.graph_objects as go

fig = go.Figure(data=[go.Sankey(
    node=dict(
        pad=15,
        thickness=20,
        label=["理科班", "工科", "商科", "IT 行业", "金融行业"],
        color="blue"
    ),
    link=dict(
        source=[0, 0],  # 起点索引
        target=[1, 2],  # 终点索引
        value=[60, 40]  # 流量大小
    )
)])

fig.update_layout(title_text="学生流向 Sankey 图", font_size=14)
fig.show()

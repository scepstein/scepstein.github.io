meat = top_items[top_items["Category"] == "Meat"]
NAME = meat["Item"].reset_index()["Item"]
SHORTHAND = meat["Shorthand"].reset_index()["Shorthand"]
ROW = [0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2]
COL = [0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 2, 3]

BLUE = "#3D85F7"
BLUE_LIGHT = "#5490FF"
PINK = "#C32E5A"
PINK_LIGHT = "#D34068"
BACKGROUND = "#e1ded0"
GREY20 = "#333333"
GREY40 = "#666666"

def single_plot(x, y1, y2, name, ax, shorthand):
    ax.plot(x, y1, color=BLUE, marker="o", markersize=2.5)
    ax.plot(x, y2, color=PINK)

    ax.fill_between(x, y1, y2, where=(y1 > y2), interpolate=True, color=BLUE_LIGHT, alpha=0.3)
    ax.fill_between(x, y1, y2, where=(y1 <= y2), interpolate=True, color=PINK_LIGHT, alpha=0.3)

    ax.set_facecolor(BACKGROUND)
    fig.set_facecolor(BACKGROUND)

    xticks = pd.to_datetime(["2018-01-01", "2020-01-01", "2022-01-01"], format="%Y-%m-%d")
    ax.set_xticks(xticks)
    ax.set_xticks(pd.to_datetime(["2019-01-01", "2021-01-01", "2021-01-01"], format="%Y-%m-%d"), minor=True)
    # added a 'size' argument
    ax.set_xticklabels(["2018", "2020", "2022"], color=GREY40, size=10)

    ax.grid(which="minor", lw=0.4, alpha=0.4)
    ax.grid(which="major", lw=0.8, alpha=0.4)

    ax.yaxis.set_tick_params(which="both", length=0)
    ax.xaxis.set_tick_params(which="both", length=0)

    ax.spines["left"].set_color("none")
    ax.spines["bottom"].set_color("none")
    ax.spines["right"].set_color("none")
    ax.spines["top"].set_color("none")

    # added a 'size' argument
    ax.set_title(shorthand, weight="bold", size=9, color=GREY20)

fig, axes = plt.subplots((max(ROW)+1), (max(COL)+1), figsize=(12, 10), sharex=False, sharey=False)

fig.suptitle("Inflation may be making my wallet cry fowl, but can you still afford a good cut of beef?", fontsize=14, fontweight='bold')
fig.text(0.5, 0.93, "A Look at Meat Prices Over Time", ha='center', fontsize=12)
fig.text(0.25, 0.93, "Y-Axis: Price for item ($)", ha='center', fontsize=10)

handles = [
    Line2D([], [], c=color, lw=1.2, label=label)
    for label, color in zip(["Observed Price", "Average Price"], [BLUE, PINK])
]

fig.legend(
    handles=handles,
    loc=(0.70, 0.925), # This coord is bottom-left corner
    ncol=2,           # 1 row, 2 columns layout
    columnspacing=1,  # Space between columns
    handlelength=1.2, # Line length
    frameon=False     # No frame
)

for i, name in enumerate(NAME):
    # Select data for the borough in 'name'
    df_mini = df[df["item_name"] == name]
    
    # Take axis out of the axes array
    ax = axes[int(ROW[i]), int(COL[i])]
    
    # Take values for x, y1 and y2.
    Date = df_mini["date"]
    unit_price = df_mini["unit_price"]
    avg_price = [df_mini["unit_price"].mean() for val in df_mini["unit_price"]]
    
    # Plot it!
    single_plot(Date, unit_price, avg_price, name, ax, SHORTHAND[i])
    

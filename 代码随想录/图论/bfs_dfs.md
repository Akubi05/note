```
void dfs(参数) {
    处理节点
    dfs(图，选择的节点); // 递归
    回溯，撤销处理结果
}

void dfs(参数) {
    if (终止条件) {
        存放结果;
        return;
    }

    for (选择：本节点所连接的其他节点) {
        处理节点;
        dfs(图，选择的节点); // 递归
        回溯，撤销处理结果
    }
}

vector<vector<int>> result; // 保存符合条件的所有路径
vector<int> path; // 起点到终点的路径
void dfs (图，目前搜索的节点)  
```

# 1. 797 所有可能的路径

## dfs

```
class Solution {
public:
    vector<vector<int>> result;
    vector<int> path;
    vector<vector<int>> allPathsSourceTarget(vector<vector<int>>& graph) {
        path.push_back(0);
        dfs(graph, 0, graph.size() - 1);
        return result;
    }

    void dfs(vector<vector<int>>& graph, int x, int n) {
        if (x == n) {
            result.push_back(path);
            return;
        }

        for (auto& i : graph[x]) {
            path.push_back(i);
            dfs(graph, i, n);
            path.pop_back();
        }
        return;
    }
};
```

## bfs 这里比较难理解
```
class Solution {
public:
    vector<vector<int>> result;
    vector<int> path;
    
    vector<vector<int>> allPathsSourceTarget(vector<vector<int>>& graph) {
        queue<vector<int>> q;  // 队列，用于广度优先搜索
        path.push_back(0);
        q.push(path);  // 初始路径从节点 0 开始
        
        int target = graph.size() - 1;  // 目标节点
        
        while (!q.empty()) {
            path = q.front();  // 取出当前路径
            q.pop();
            
            int node = path.back();  // 当前路径的最后一个节点
            
            if (node == target) {
                result.push_back(path);  // 到达目标节点，保存路径
                continue;
            }
            
            // 对当前节点的所有相邻节点进行扩展
            for (int neighbor : graph[node]) {
                vector<int> newPath = path;  // 创建新路径
                newPath.push_back(neighbor);  // 扩展路径
                q.push(newPath);  // 将新路径入队
            }
        }
        
        return result;
    }
};

```


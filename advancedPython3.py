def merge(intervals):
    intervals = sorted(intervals, key= lambda arr: arr[0])
    stack = []
    for arr in intervals:
        if not stack:
            stack.append(arr)
        elif arr[0] > stack[-1][1]:
            stack.append(arr)
        else:
            stack[-1][1] = max(stack[-1][1], arr[1])
    return stack
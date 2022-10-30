from math import sqrt
from unittest import result
import numpy as np
import matplotlib.pyplot as plt
import datetime

N = 10001
n = int(pow(N, 0.75))


def lazySelect(l: int):
    S = list(np.random.randint(1, 100001, N))
    R = S[:n]
    R.sort()
    d = R[int(0.5*n-l)-1]
    u = R[int(0.5*n+l)-1]

    C = []
    l_d = 0
    l_u = 0
    for x in S:
        if x < d:
            l_d = l_d+1
        elif x > u:
            l_u = l_u+1
        else:
            C.append(x)

    if l_d <= N/2 and l_u <= N/2 and len(C) <= 4*n:
        C.sort()
        S.sort()
        if S[int(N/2)] == (C[int(N/2)-l_d]):
            return 1
        else:
            return 0
    else:
        return 0


times = []
counts = []
for l in range(int(sqrt(N)), 0, -1):
    time = 0
    count = 0
    for i in range(0, 1000):
        t1 = datetime.datetime.now()
        result = lazySelect(l)
        t2 = datetime.datetime.now()
        time = time+(t2-t1).microseconds/1000000
        if result:
            count = count+1
    counts.append(count/1000)
    times.append(time/1000)
    print("the distance is {} and the correct rating is {}".format(l, count/1000))

plt.plot(range(int(sqrt(N)), 0, -1), counts)
plt.legend(loc="upper right")
plt.xlabel("Distance")
plt.ylabel("Correct Rating")
plt.show()
plt.savefig("Times.png")

plt.plot(range(int(sqrt(N)), 0, -1), times)
plt.legend(loc="upper right")
plt.xlabel("Distance")
plt.ylabel("Times")
plt.show()
plt.savefig("Times.png")

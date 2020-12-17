policy = [6/7, 1/7];
pi = ones(7,2);
pi(:,1) = 0;
b = ones(7,2)/7;
features = [[2,0,0,0,0,0,0,1];[0,2,0,0,0,0,0,1];[0,0,2,0,0,0,0,1];[0,0,0,2,0,0,0,1];[0,0,0,0,2,0,0,1];[0,0,0,0,0,2,0,1];[0,0,0,0,0,0,1,2]];
features = transpose(features);
w = [1,1,1,1,1,1,10,1];
alpha = 0.01;
gamma = 0.99;
all_weights = [];
time_step = 0;
state = randi(7,1);
while time_step<=1000
    action = randsample([1,2],1,true,policy);
    if action == 1
        next_state = randi(6,1);
    else
        next_state = 7;
    end
    Reward = 0;
    value_S_dash = w*features(:,next_state);
    value_S = w*features(:,state);
    rho = pi(state,action)/b(state,action);
    w = w + transpose(alpha*rho*(Reward + gamma*(value_S_dash) - value_S).*features(:,state));
    all_weights = [all_weights;w];
    time_step = time_step+1;
    state = next_state; 
end
for i=1:8
    plot([1:1001], all_weights(:,i))
    hold on;
end
legend('w1','w2','w3','w4','w5','w6','w7','w8')
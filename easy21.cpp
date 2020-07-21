/********************************Author: LiChang********************************/
/********************************Time: 2020/6/8********************************/
#include <iostream>
#include<stdlib.h>
#include <time.h>
#include <algorithm>
#include <fstream>
using namespace std;
#define episode 20000
#define E 0
#define A 0.01

enum color {red, black};
enum action {hit, stick};

struct state
{
	int dealer_s;
	int sum;
};
struct stepresult
{
	state nextstate;
	int reward;
};

//draw the first card
int firstdraw()
{
	return (int)(rand() % 10+1);
}

int draw()
{
	color t_color;
	int result = 0;

	if ((int)(rand() % 3) == 0)
		t_color = red;
	else
		t_color = black;

	if (t_color == red)
		result = -(int)(rand() % 10+1);
	else
		result = (int)(rand() % 10+1);
	return result;
}

//player take an action and return nextstate and reward
stepresult step(state t_state, action t_action)
{
	stepresult result;
	if (t_action == hit)
	{
		result.nextstate.sum = t_state.sum + draw();
		result.nextstate.dealer_s = t_state.dealer_s;
		if (result.nextstate.sum < 1 || result.nextstate.sum>21)
		{
			result.nextstate.sum = 0;
			result.reward = -1;			//player bust, player lose
		}
		//game is not over, no reward.
		else result.reward = 0;
	}
	else if (t_action == stick)
	{
		result.nextstate.sum = t_state.sum;
		result.nextstate.dealer_s = 0;
		int dealer_sum = t_state.dealer_s;
		//player stick so dealer begin to draw
		while (dealer_sum > 0 && dealer_sum < 16)
		{
			dealer_sum += draw();
		}
		//result.nextstate.dealer_s = dealer_sum;
		if (dealer_sum < 1 || dealer_sum>21)
		{
			result.reward = 1;			//dealer bust, player win
		}
		else if (dealer_sum < t_state.sum)
			result.reward = 1;			//player win
		else if (dealer_sum == t_state.sum)
			result.reward = 0;			//equal so tie
		else if (dealer_sum > t_state.sum)
			result.reward = -1;			//player lose
	}
	return result;
}

int main()
{
	srand((unsigned int)(time(NULL)));
	ofstream reward_episode_log;
	ofstream value_state_action_log;
	reward_episode_log.open("reward_episode_log.txt", ios::out | ios::app);
	value_state_action_log.open("value_state_action_log.txt", ios::out | ios::app);
	//initiate qtable
	double qtable[242][2];
	for (int i = 0; i < 242; i++)
	{
		for (int j = 0; j < 2; j++)
			qtable[i][j] = 0;
	}
	
	int win_times = 0;
	int total_reward = 0;
	for (int i = 1; i < episode+1; i++)
	{
		state c_state;
		stepresult c_result;
		action c_action;
		c_state.dealer_s = firstdraw();
		c_state.sum = firstdraw();
		c_result.nextstate = c_state;
		c_result.reward = 0;
		//a round of game
		while (1)
		{

			int q_state = 22 * c_result.nextstate.dealer_s + c_result.nextstate.sum;
			if (qtable[q_state][hit] > qtable[q_state][stick])
			{
				if (rand() % 10000 > 10000 * E)
					c_action = hit;
				else
					c_action = stick;
			}
			else if (qtable[q_state][hit] < qtable[q_state][stick])
			{
				if (rand() % 10000 > 10000 * E)
					c_action = stick;
				else
					c_action = hit;
			}
			else
			{
				if (rand() % 2 == 0) 
					c_action = hit;
				else
					c_action = stick;
			}
			c_result = step(c_result.nextstate, c_action);

			int nq_state = 22 * c_result.nextstate.dealer_s + c_result.nextstate.sum;
			qtable[q_state][c_action] += A * ((double)(c_result.reward) + max(qtable[nq_state][hit], qtable[nq_state][stick]) - qtable[q_state][c_action]);			//update qtable
			//a round of game end, add reward to qtable
			if (c_result.nextstate.dealer_s == 0 || c_result.nextstate.sum == 0)
			{
				break;
			}
		}
		total_reward += c_result.reward;
		if(c_result.reward==1)
			win_times += 1;
		if (i % 1000 == 0)
		{
			cout << i << "\t" << c_result.reward << "\twin rate:\t" << (double)(win_times)/(double)(i) << "\t\t" << "total reward:    " << total_reward << "\n";
			
			reward_episode_log << i << "\t" << (double)(win_times) / (double)(i) << "\t" << total_reward << "\n";
			total_reward = 0;
		}
	}
	reward_episode_log.close();

	for (int p = 0; p < 242; p++)
	{
		int player = p % 22;
		int dealer = (p - player) / 22;
		double max_q = max(qtable[p][0], qtable[p][1]);
		value_state_action_log << dealer << "\t" << player << "\t" << max_q << "\n";
	}
	value_state_action_log.close();
	
	for (int j = 0; j < 242; j++)
	{
		cout << "dealer_sum:    " << (j - j % 22)/22 << "\t" << "player_sum:    " << j % 22 << "\t";
		for (int k = 0; k < 2; k++)
		{
			string action_option;
			if (k == 0)
				action_option = "hit:";
			else
				action_option = "stick:";
			cout << action_option << "\t" << qtable[j][k] << "\t";
		}
		string action_tendency;
		if (qtable[j][0] > qtable[j][1])
			action_tendency = "tend to choose hit";
		else
			action_tendency = "tend to choose stick";

		cout << action_tendency << "\n";
	}
}
/*
 * Метод Рунге-Кутты 4-го порядка с адаптивным шагом
 *
 * Антон Остроухов
 * a.ostrouhhov@gmail.com
 */

#include <iostream>
#include <cmath>
#include <vector>
using namespace std;

// Само дифференциальное уравнение
double f(double x, double y) {
    return (-2)*y;
    // Ссылка для проверки:
    // https://www.wolframalpha.com/input/?i=solve+%7By%27(x)+%3D+-2+y,+y(0)%3D1%7D+from+0+to+10+using+r+k+f+algorithm&lk=3
}

// Метод Р-К 4-го порядка
double rk1(double x, double y, double h) {
    double k1=h*f(x, y);
    double k2=h*f(x+h/2, y+k1/2);
    double k3=h*f(x+h/2, y+k2/2);
    double k4=h*f(x+h, y+k3);

    double k=(k1+2*k2+2*k3+k4)/6;
    return y + k;
}

int main() {
    double eps = 0.0000001; // Для сравнения y2 и y
    double h=0.03125;       // Начальная величина шага
    double y1 = 0;          // Промежуточный y, нужный для вычисления y2
    double y2 = 0;          // y, полученный методом Р-К в 2 шага с h=h/2
    int i=0;                // Для итерации по массивам с ответами
    int flag = 1;
    vector<double> X;       // Массив для хранения x-ов 
    vector<double> Y;       // Массив для хранения y-ов
    double x = 0;           // Начальное значение x0
    double y = 1;           // Начальное значение y0 = y(x0)
    
    X.push_back(x);
    Y.push_back(y);
    cout<<"x="<<x<<" "<<"y="<<y<<endl;
    
    while(x<=10) {
        y = rk1(x, Y.at(i), h);
        y1 = rk1(x, Y.at(i), h/2);
        y2 = rk1(x+h/2, y1, h/2);

        if(abs(y-y2)<eps) {
            if(flag == 1){
                h=h*2;
            }
            
            if(flag==0) {
                Y.push_back(y);
                x+=h;
                X.push_back(x);
                i++;
                flag= 1;
                cout<<"x="<<x<<" "<<"y="<<y<<endl;
            }
        } else {
            h=h/2;
            flag=0;
        }
    }
    
    return 0;
}

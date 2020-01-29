#include<bits/stdc++.h>
using namespace std;

#define MOD 1000000007
#define PRIME 727

FILE *logout;
FILE *tokenout;


class SymbolInfo{
private:
        //string name = "", type = "";
public:
        string name, type;//ekhane change korchi, name = "", type = "" chilo
        SymbolInfo() : name(), type() {};
        SymbolInfo(string name, string type)
        {
                this->name = name;
                this->type = type;
        }
        void PrintSymbolInfo()
        {
                //if(this->name == ""  &&  this->type == "") return;
                cout << "<" << this->name << "," << this->type << "> " ;
        }
        void PrintSymbolInfoInHashTableForm()
        {
                //if(this->name == ""  &&  this->type == "") return;
                //cout << "< " << this->name << " : " << this->type << " > " ;
		fprintf(logout, "<%s,%s>", this->name.c_str(), this->type.c_str());
        }
        string getName()
        {
                return this->name;
        }
        string getType()
        {
                return this->type;
        }
        void setName(string name)
        {
                this->name = name;
                //cout << this->name << endl;
        }
        void setType(string type)
        {
                this->type = type;
                //cout << this->type << endl;
        }
        /*SymbolInfo operator = (const SymbolInfo &sym)
        {
                this->setName(sym.name);
                this->setType(sym.type);
                //return this;
        }*/
};

class LinkedListNode{
public:
        SymbolInfo *tuple_;
        LinkedListNode *next;
        LinkedListNode()
        {
                tuple_ = new SymbolInfo();
                next = NULL;
        }
        LinkedListNode(string &name, string &type)
        {
                tuple_ = new SymbolInfo(name, type);
                next = NULL;
        }
};


class SymbolTable{
private:
        LinkedListNode** hashtable;
        int sz;
public:
        SymbolTable(int sz)
        {
                if(sz < 1)
                {
                        cout << "Hash table size cannot be less than 1" << endl;
                        return;
                }
                this->sz = sz;
                hashtable = new LinkedListNode*[sz];
                for(int i = 0; i < sz; ++i)
                        hashtable[i] = NULL;//ekhane barbar vul hocchilo, new LinkedListNode() chilo
        }
        int modular_pow(int base, int exponent, int modulus)
        {
                int result = 1;
                while (exponent > 0)
                {
                        if (exponent % 2 == 1)
                            result = (result * base) % modulus;
                        exponent = exponent >> 1;
                        base = (base * base) % modulus;
                }
                return result;
        }
        int getHashValue(string s)//-ve value aste pare, thik korte hobe
        {
                int hashSum = 0;
                for(int i = 0; i < s.size(); ++i)
                        hashSum = (hashSum + ((s[i] % 10) * modular_pow(PRIME, i, MOD)) % MOD) % MOD;
                return hashSum % this->sz;
        }
        bool find(string s)
        {
                int hashValue = getHashValue(s);
                LinkedListNode* now = hashtable[hashValue];
                while(now != NULL)
                {
                        //SymbolInfo temp = new SymbolInfo(s, iden);
                        if(now->tuple_->getName() == s)
                                return true;
                        now = now->next;
                }
                return false;
        }
        string getIdentifier(string s)
        {
                int hashValue = getHashValue(s);
                LinkedListNode* now = hashtable[hashValue];
                while(now != NULL)
                {
                        //SymbolInfo temp = new SymbolInfo(s, iden);
                        if(now->tuple_->getName() == s)
                                return now->tuple_->getType();
                        now = now->next;
                }
        }
        int findIndex(string s)
        {
                int hashValue = getHashValue(s);
                LinkedListNode* now = hashtable[hashValue];
                int i = 0;
                while(now != NULL)
                {
                        if(now->tuple_->getName() == s)
                                return i;
                        now = now->next;
                        i++;
                }
        }
        void insert(string s, string iden)
        {
                int hashValue = getHashValue(s);
                LinkedListNode* now = hashtable[hashValue];
                //now->tuple_.PrintSymbolInfo();
                //if(now->tuple_.getName() == ""  &&  now->tuple_.getType() == "")//this chain is empty
                if(now == NULL)
                {
                        LinkedListNode* temp = new LinkedListNode(s, iden);
                        //temp->tuple_->PrintSymbolInfo();
                        hashtable[hashValue] = temp;
                        //cout << "head" << endl;
                        temp->tuple_->PrintSymbolInfo();
                        //cout << "inserted at " << hashValue << ", 0" << endl;
                        //hashtable[hashValue]->tuple_->PrintSymbolInfo();
                        return;
                }
                if(find(s))
                {
                        int index = findIndex(s);
			fprintf(logout, "<%s,%s> already exits\n\n", s.c_str(), iden.c_str());
                        //now->tuple_->PrintSymbolInfo();
                        //cout << "<" << s << "," << iden << ">";
                        //cout << " already exists" << endl;
                        return;
                }
                int i = 0;
                LinkedListNode* prev = now;
                while(now != NULL)
                {
                        //now->tuple_->PrintSymbolInfo();
                        prev = now;
                        now = now->next;
                        i++;
                }
                LinkedListNode* temp = new LinkedListNode(s, iden);
                prev->next = temp;
                temp->tuple_->PrintSymbolInfo();
                //cout << "inserted at " << hashValue << ", " << i << endl;
        }
        void lookUp(string s)
        {
                if(find(s))
                        cout << "<" << s << " " << getIdentifier(s) << "> " << "found at " << getHashValue(s) << ", " << findIndex(s) << endl;
                else
                        cout << s << " not found" << endl;
        }
        void delete_(string s)
        {
                int hashValue = getHashValue(s);
                LinkedListNode* now = hashtable[hashValue];
                if(now == NULL  ||  find(s) == false)
                {
                        cout << s << " not found" << endl;
                        return;
                }
                int i = 0;
                LinkedListNode* prev = now;
                while(now->tuple_->getName() != s)
                {
                        //now->tuple_->PrintSymbolInfo();
                        prev = now;
                        now = now->next;
                        i++;
                }
                prev->next = now->next;
                if(prev == now)//means we have to delete the head
                {
                        hashtable[hashValue] = now->next;
                }
                delete now;
                cout << "Deleted from " << hashValue << ", " << i << endl;
        }
        void printTable()
        {
                for(int i = 0; i < this->sz; ++i)
                {
                        //cout << i << " --> ";
                        LinkedListNode* now = hashtable[i];
			if(now == NULL)
				continue;
			fprintf(logout, "%d --> ", i);
                        while(now != NULL)
                        {
                                now->tuple_->PrintSymbolInfoInHashTableForm();
                                now = now->next;
                        }
                        //cout << endl;
			fprintf(logout, "\n");
                }
        }
};

/*int main()
{
        freopen("in.txt", "r", stdin);
        int n;
        cin >> n;
        SymbolTable symboltable(n);
        char ch;
        while(cin >> ch)
        {
                string s, t;
                if(ch == 'I')
                {
                        cin >> s >> t;
                        symboltable.insert(s, t);
                }
                else if(ch == 'P')
                        symboltable.printTable();
                else if(ch == 'L')
                {
                        cin >> s;
                        symboltable.lookUp(s);
                }
                else if(ch == 'D')
                {
                        cin >> s;
                        symboltable.delete_(s);
                }
                cout << endl;
        }
        return 0;
}*/

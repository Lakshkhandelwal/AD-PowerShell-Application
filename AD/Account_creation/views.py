from django.shortcuts import render

def home(request):
    return render(request,'Account_creation\home.html')

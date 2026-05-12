-- NutriCart User Data, Meal History, Health Conditions, and Adaptive Learning Migration
-- Location: supabase/migrations/20260124133700_nutricart_user_data.sql

-- ============================================================================
-- STEP 1: CUSTOM TYPES
-- ============================================================================

CREATE TYPE public.gender_type AS ENUM ('male', 'female', 'other');
CREATE TYPE public.feedback_status AS ENUM ('eaten', 'skipped', 'partial');
CREATE TYPE public.meal_type AS ENUM ('breakfast', 'lunch', 'dinner', 'snacks');

-- ============================================================================
-- STEP 2: CORE TABLES
-- ============================================================================

-- User Profiles (extends auth.users)
CREATE TABLE public.user_profiles (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    email TEXT NOT NULL UNIQUE,
    full_name TEXT NOT NULL,
    age INTEGER CHECK (age >= 18 AND age <= 100),
    gender public.gender_type,
    weight DECIMAL(5,2) CHECK (weight >= 30 AND weight <= 200),
    monthly_budget DECIMAL(10,2),
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

-- Health Conditions
CREATE TABLE public.health_conditions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES public.user_profiles(id) ON DELETE CASCADE,
    condition_name TEXT NOT NULL,
    hba1c DECIMAL(4,2),
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

-- Dietary Preferences
CREATE TABLE public.dietary_preferences (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES public.user_profiles(id) ON DELETE CASCADE,
    preference_name TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

-- Allergies
CREATE TABLE public.allergies (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES public.user_profiles(id) ON DELETE CASCADE,
    allergen_name TEXT NOT NULL,
    severity TEXT,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

-- Meal History (tracks actual meals consumed)
CREATE TABLE public.meal_history (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES public.user_profiles(id) ON DELETE CASCADE,
    meal_id TEXT NOT NULL,
    meal_name TEXT NOT NULL,
    meal_type public.meal_type NOT NULL,
    meal_date DATE NOT NULL,
    calories DECIMAL(8,2),
    protein DECIMAL(6,2),
    carbs DECIMAL(6,2),
    fat DECIMAL(6,2),
    fiber DECIMAL(6,2),
    cost DECIMAL(8,2),
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

-- Meal Feedback (tracks user consumption patterns)
CREATE TABLE public.meal_feedback (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES public.user_profiles(id) ON DELETE CASCADE,
    meal_id TEXT NOT NULL,
    meal_type public.meal_type NOT NULL,
    feedback_date DATE NOT NULL,
    status public.feedback_status NOT NULL,
    portion_consumed DECIMAL(3,2) CHECK (portion_consumed >= 0 AND portion_consumed <= 1),
    reason TEXT,
    timestamp TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

-- Adaptive Learning Patterns (stores learned preferences and adjustments)
CREATE TABLE public.adaptive_patterns (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES public.user_profiles(id) ON DELETE CASCADE,
    meal_type public.meal_type NOT NULL,
    pattern_type TEXT NOT NULL, -- 'portion_adjustment', 'meal_replacement', 'skip_pattern'
    pattern_data JSONB NOT NULL,
    confidence_score DECIMAL(3,2) CHECK (confidence_score >= 0 AND confidence_score <= 1),
    last_updated TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

-- Daily Meal Plans (stores generated meal plans)
CREATE TABLE public.daily_meal_plans (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES public.user_profiles(id) ON DELETE CASCADE,
    plan_date DATE NOT NULL,
    meals JSONB NOT NULL,
    daily_targets JSONB NOT NULL,
    adjusted_targets JSONB NOT NULL,
    adaptation_score DECIMAL(3,2) CHECK (adaptation_score >= 0 AND adaptation_score <= 1),
    total_calories DECIMAL(8,2),
    total_cost DECIMAL(8,2),
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(user_id, plan_date)
);

-- Nutrient Tracking (daily nutrient consumption summary)
CREATE TABLE public.nutrient_tracking (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES public.user_profiles(id) ON DELETE CASCADE,
    tracking_date DATE NOT NULL,
    calories DECIMAL(8,2),
    protein DECIMAL(6,2),
    carbs DECIMAL(6,2),
    fat DECIMAL(6,2),
    fiber DECIMAL(6,2),
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(user_id, tracking_date)
);

-- ============================================================================
-- STEP 3: INDEXES
-- ============================================================================

CREATE INDEX idx_user_profiles_email ON public.user_profiles(email);
CREATE INDEX idx_health_conditions_user_id ON public.health_conditions(user_id);
CREATE INDEX idx_dietary_preferences_user_id ON public.dietary_preferences(user_id);
CREATE INDEX idx_allergies_user_id ON public.allergies(user_id);
CREATE INDEX idx_meal_history_user_id ON public.meal_history(user_id);
CREATE INDEX idx_meal_history_date ON public.meal_history(meal_date);
CREATE INDEX idx_meal_feedback_user_id ON public.meal_feedback(user_id);
CREATE INDEX idx_meal_feedback_date ON public.meal_feedback(feedback_date);
CREATE INDEX idx_adaptive_patterns_user_id ON public.adaptive_patterns(user_id);
CREATE INDEX idx_daily_meal_plans_user_id ON public.daily_meal_plans(user_id);
CREATE INDEX idx_daily_meal_plans_date ON public.daily_meal_plans(plan_date);
CREATE INDEX idx_nutrient_tracking_user_id ON public.nutrient_tracking(user_id);
CREATE INDEX idx_nutrient_tracking_date ON public.nutrient_tracking(tracking_date);

-- ============================================================================
-- STEP 4: FUNCTIONS
-- ============================================================================

-- Trigger function to create user profile automatically
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
    INSERT INTO public.user_profiles (id, email, full_name)
    VALUES (
        NEW.id,
        NEW.email,
        COALESCE(NEW.raw_user_meta_data->>'full_name', split_part(NEW.email, '@', 1))
    );
    RETURN NEW;
END;
$$;

-- Function to update updated_at timestamp
CREATE OR REPLACE FUNCTION public.update_updated_at_column()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$;

-- ============================================================================
-- STEP 5: ENABLE ROW LEVEL SECURITY
-- ============================================================================

ALTER TABLE public.user_profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.health_conditions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.dietary_preferences ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.allergies ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.meal_history ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.meal_feedback ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.adaptive_patterns ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.daily_meal_plans ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.nutrient_tracking ENABLE ROW LEVEL SECURITY;

-- ============================================================================
-- STEP 6: RLS POLICIES
-- ============================================================================

-- User Profiles Policies
CREATE POLICY "users_manage_own_user_profiles"
ON public.user_profiles
FOR ALL
TO authenticated
USING (id = auth.uid())
WITH CHECK (id = auth.uid());

-- Health Conditions Policies
CREATE POLICY "users_manage_own_health_conditions"
ON public.health_conditions
FOR ALL
TO authenticated
USING (user_id = auth.uid())
WITH CHECK (user_id = auth.uid());

-- Dietary Preferences Policies
CREATE POLICY "users_manage_own_dietary_preferences"
ON public.dietary_preferences
FOR ALL
TO authenticated
USING (user_id = auth.uid())
WITH CHECK (user_id = auth.uid());

-- Allergies Policies
CREATE POLICY "users_manage_own_allergies"
ON public.allergies
FOR ALL
TO authenticated
USING (user_id = auth.uid())
WITH CHECK (user_id = auth.uid());

-- Meal History Policies
CREATE POLICY "users_manage_own_meal_history"
ON public.meal_history
FOR ALL
TO authenticated
USING (user_id = auth.uid())
WITH CHECK (user_id = auth.uid());

-- Meal Feedback Policies
CREATE POLICY "users_manage_own_meal_feedback"
ON public.meal_feedback
FOR ALL
TO authenticated
USING (user_id = auth.uid())
WITH CHECK (user_id = auth.uid());

-- Adaptive Patterns Policies
CREATE POLICY "users_manage_own_adaptive_patterns"
ON public.adaptive_patterns
FOR ALL
TO authenticated
USING (user_id = auth.uid())
WITH CHECK (user_id = auth.uid());

-- Daily Meal Plans Policies
CREATE POLICY "users_manage_own_daily_meal_plans"
ON public.daily_meal_plans
FOR ALL
TO authenticated
USING (user_id = auth.uid())
WITH CHECK (user_id = auth.uid());

-- Nutrient Tracking Policies
CREATE POLICY "users_manage_own_nutrient_tracking"
ON public.nutrient_tracking
FOR ALL
TO authenticated
USING (user_id = auth.uid())
WITH CHECK (user_id = auth.uid());

-- ============================================================================
-- STEP 7: TRIGGERS
-- ============================================================================

-- Trigger to create user profile on auth user creation
CREATE TRIGGER on_auth_user_created
    AFTER INSERT ON auth.users
    FOR EACH ROW
    EXECUTE FUNCTION public.handle_new_user();

-- Triggers to update updated_at timestamp
CREATE TRIGGER update_user_profiles_updated_at
    BEFORE UPDATE ON public.user_profiles
    FOR EACH ROW
    EXECUTE FUNCTION public.update_updated_at_column();

CREATE TRIGGER update_health_conditions_updated_at
    BEFORE UPDATE ON public.health_conditions
    FOR EACH ROW
    EXECUTE FUNCTION public.update_updated_at_column();

CREATE TRIGGER update_daily_meal_plans_updated_at
    BEFORE UPDATE ON public.daily_meal_plans
    FOR EACH ROW
    EXECUTE FUNCTION public.update_updated_at_column();

-- ============================================================================
-- STEP 8: MOCK DATA
-- ============================================================================

DO $$
DECLARE
    demo_user_uuid UUID := gen_random_uuid();
    test_user_uuid UUID := gen_random_uuid();
    meal_plan_id UUID;
BEGIN
    -- Create auth users with complete field structure
    INSERT INTO auth.users (
        id, instance_id, aud, role, email, encrypted_password, email_confirmed_at,
        created_at, updated_at, raw_user_meta_data, raw_app_meta_data,
        is_sso_user, is_anonymous, confirmation_token, confirmation_sent_at,
        recovery_token, recovery_sent_at, email_change_token_new, email_change,
        email_change_sent_at, email_change_token_current, email_change_confirm_status,
        reauthentication_token, reauthentication_sent_at, phone, phone_change,
        phone_change_token, phone_change_sent_at
    ) VALUES
        (demo_user_uuid, '00000000-0000-0000-0000-000000000000', 'authenticated', 'authenticated',
         'demo@nutricart.com', crypt('demo123', gen_salt('bf', 10)), now(), now(), now(),
         '{"full_name": "Demo User"}'::jsonb,
         '{"provider": "email", "providers": ["email"]}'::jsonb,
         false, false, '', null, '', null, '', '', null, '', 0, '', null, null, '', '', null),
        (test_user_uuid, '00000000-0000-0000-0000-000000000000', 'authenticated', 'authenticated',
         'test@nutricart.com', crypt('test123', gen_salt('bf', 10)), now(), now(), now(),
         '{"full_name": "Test User"}'::jsonb,
         '{"provider": "email", "providers": ["email"]}'::jsonb,
         false, false, '', null, '', null, '', '', null, '', 0, '', null, null, '', '', null);

    -- Update user profiles with additional details
    UPDATE public.user_profiles
    SET age = 32, gender = 'male'::public.gender_type, weight = 75.5, monthly_budget = 8000.00
    WHERE id = demo_user_uuid;

    UPDATE public.user_profiles
    SET age = 28, gender = 'female'::public.gender_type, weight = 62.0, monthly_budget = 6000.00
    WHERE id = test_user_uuid;

    -- Insert health conditions
    INSERT INTO public.health_conditions (user_id, condition_name, hba1c, notes)
    VALUES
        (demo_user_uuid, 'Diabetes', 6.5, 'Type 2 diabetes, managing with diet'),
        (demo_user_uuid, 'Hypertension', null, 'Mild hypertension, low sodium diet recommended');

    -- Insert dietary preferences
    INSERT INTO public.dietary_preferences (user_id, preference_name)
    VALUES
        (demo_user_uuid, 'Vegetarian'),
        (demo_user_uuid, 'South Indian'),
        (test_user_uuid, 'Non-Vegetarian'),
        (test_user_uuid, 'North Indian');

    -- Insert allergies
    INSERT INTO public.allergies (user_id, allergen_name, severity)
    VALUES
        (demo_user_uuid, 'Peanuts', 'Moderate'),
        (test_user_uuid, 'Shellfish', 'Severe');

    -- Insert meal history
    INSERT INTO public.meal_history (user_id, meal_id, meal_name, meal_type, meal_date, calories, protein, carbs, fat, fiber, cost)
    VALUES
        (demo_user_uuid, 'idli_001', 'Idli with Sambar', 'breakfast'::public.meal_type, CURRENT_DATE - INTERVAL '1 day', 214, 10.5, 35.3, 4.3, 8.0, 33.00),
        (demo_user_uuid, 'sambar_001', 'Sambar with Rice', 'lunch'::public.meal_type, CURRENT_DATE - INTERVAL '1 day', 341, 13.6, 55.4, 8.9, 8.0, 50.00),
        (demo_user_uuid, 'dosa_001', 'Masala Dosa', 'dinner'::public.meal_type, CURRENT_DATE - INTERVAL '1 day', 310, 8.3, 46.8, 10.6, 4.4, 40.00),
        (test_user_uuid, 'roti_dal_001', 'Roti with Dal Tadka', 'lunch'::public.meal_type, CURRENT_DATE - INTERVAL '1 day', 272, 12.4, 43.4, 6.9, 8.6, 35.00);

    -- Insert meal feedback
    INSERT INTO public.meal_feedback (user_id, meal_id, meal_type, feedback_date, status, portion_consumed, reason)
    VALUES
        (demo_user_uuid, 'idli_001', 'breakfast'::public.meal_type, CURRENT_DATE - INTERVAL '1 day', 'eaten'::public.feedback_status, 1.0, null),
        (demo_user_uuid, 'sambar_001', 'lunch'::public.meal_type, CURRENT_DATE - INTERVAL '1 day', 'partial'::public.feedback_status, 0.75, 'Too much quantity'),
        (demo_user_uuid, 'dosa_001', 'dinner'::public.meal_type, CURRENT_DATE - INTERVAL '1 day', 'eaten'::public.feedback_status, 1.0, null),
        (test_user_uuid, 'roti_dal_001', 'lunch'::public.meal_type, CURRENT_DATE - INTERVAL '1 day', 'eaten'::public.feedback_status, 1.0, null);

    -- Insert adaptive patterns
    INSERT INTO public.adaptive_patterns (user_id, meal_type, pattern_type, pattern_data, confidence_score)
    VALUES
        (demo_user_uuid, 'lunch'::public.meal_type, 'portion_adjustment', '{"multiplier": 0.85, "reason": "User consistently eats 75-85% of lunch portions"}'::jsonb, 0.82),
        (demo_user_uuid, 'breakfast'::public.meal_type, 'meal_replacement', '{"avoided_meals": ["poha"], "preferred_meals": ["idli", "dosa"]}'::jsonb, 0.75);

    -- Insert daily meal plan
    meal_plan_id := gen_random_uuid();
    INSERT INTO public.daily_meal_plans (id, user_id, plan_date, meals, daily_targets, adjusted_targets, adaptation_score, total_calories, total_cost)
    VALUES
        (meal_plan_id, demo_user_uuid, CURRENT_DATE,
         '{"breakfast": {"meal": {"id": "idli_001", "name": "Idli with Sambar", "calories": 214}, "portionMultiplier": 1.0}, "lunch": {"meal": {"id": "sambar_001", "name": "Sambar with Rice", "calories": 341}, "portionMultiplier": 0.85}, "dinner": {"meal": {"id": "dosa_001", "name": "Masala Dosa", "calories": 310}, "portionMultiplier": 1.0}}'::jsonb,
         '{"calories": 1800, "protein": 60, "carbs": 225, "fat": 50, "fiber": 30}'::jsonb,
         '{"calories": 1750, "protein": 58, "carbs": 220, "fat": 48, "fiber": 28}'::jsonb,
         0.65, 1750.00, 123.00);

    -- Insert nutrient tracking
    INSERT INTO public.nutrient_tracking (user_id, tracking_date, calories, protein, carbs, fat, fiber)
    VALUES
        (demo_user_uuid, CURRENT_DATE - INTERVAL '1 day', 865, 32.4, 137.5, 23.8, 20.4),
        (test_user_uuid, CURRENT_DATE - INTERVAL '1 day', 272, 12.4, 43.4, 6.9, 8.6);

    RAISE NOTICE 'Mock data created successfully for NutriCart';
END $$;
